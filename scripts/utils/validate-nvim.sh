#!/bin/bash
# Test neovim configuration for basic functionality and health

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Test results
TESTS_PASSED=0
TESTS_FAILED=0
TESTS_TOTAL=0

# Configuration
NVIM_CONFIG_DIR="$HOME/.config/nvim"
TIMEOUT_SHORT=10
TIMEOUT_MEDIUM=20
TIMEOUT_LONG=30

print_header() {
    echo -e "\n${BLUE}=== $1 ===${NC}"
}

print_test() {
    echo -e "${YELLOW}Testing: $1${NC}"
}

test_passed() {
    echo -e "${GREEN}✓ PASS: $1${NC}"
    ((TESTS_PASSED++))
    ((TESTS_TOTAL++))
}

test_failed() {
    echo -e "${RED}✗ FAIL: $1${NC}"
    if [ -n "$2" ]; then
        echo -e "${RED}  Error: $2${NC}"
    fi
    ((TESTS_FAILED++))
    ((TESTS_TOTAL++))
}

test_warning() {
    echo -e "${YELLOW}⚠ WARNING: $1${NC}"
    if [ -n "$2" ]; then
        echo -e "${YELLOW}  Note: $2${NC}"
    fi
}

print_summary() {
    print_header "Summary"
    echo "SUMMARY: $TESTS_TOTAL tests, $TESTS_PASSED passed, $TESTS_FAILED failed"
}

test_nvim_installation() {
    print_test "Neovim installation"

    if command -v nvim >/dev/null 2>&1; then
        local version=$(nvim --version | head -1)
        test_passed "Neovim is installed: $version"

        # Check version (warn if < 0.10.0)
        local version_num=$(nvim --version | head -1 | grep -o 'v[0-9]\+\.[0-9]\+' | tr -d 'v')
        if [ -n "$version_num" ]; then
            local major=$(echo "$version_num" | cut -d. -f1)
            local minor=$(echo "$version_num" | cut -d. -f2)
            if [ "$major" -eq 0 ] && [ "$minor" -lt 10 ]; then
                test_warning "Neovim version is old ($version_num)" "Consider upgrading to 0.10.0+"
            fi
        fi
    else
        test_failed "Neovim is not installed or not in PATH"
        return 1
    fi
}

test_config_directory() {
    print_test "Configuration directory"

    # Check for init file
    if [ -f "$NVIM_CONFIG_DIR/init.lua" ]; then
        test_passed "init.lua found"
    elif [ -f "$NVIM_CONFIG_DIR/init.vim" ]; then
        test_passed "init.vim found"
    else
        test_warning "No init.lua or init.vim found" "Configuration may be minimal"
    fi
}

test_basic_startup() {
    print_test "Basic startup"

    if timeout $TIMEOUT_SHORT nvim --headless -c "quit" 2>/dev/null; then
        test_passed "Neovim starts and exits cleanly"
    else
        test_failed "Neovim failed to start" "Check for syntax errors in configuration"
        return 1
    fi
}

test_lua_syntax() {
    print_test "Lua configuration syntax"

    local lua_files=(
        "$NVIM_CONFIG_DIR/init.lua"
        "$NVIM_CONFIG_DIR/lua/config/options.lua"
        "$NVIM_CONFIG_DIR/lua/config/keymaps.lua"
        "$NVIM_CONFIG_DIR/lua/config/autocmds.lua"
    )

    local syntax_errors=0

    for file in "${lua_files[@]}"; do
        if [ -f "$file" ]; then
            if command -v luac >/dev/null 2>&1; then
                if luac -p "$file" 2>/dev/null; then
                    test_passed "Lua syntax valid: $(basename $file)"
                else
                    test_failed "Lua syntax error: $(basename $file)"
                    ((syntax_errors++))
                fi
            else
                test_warning "Cannot check Lua syntax for $(basename $file)" "luac not available"
            fi
        fi
    done

    # Check for other Lua files in lua/ directory
    if [ -d "$NVIM_CONFIG_DIR/lua" ]; then
        local lua_count=$(find "$NVIM_CONFIG_DIR/lua" -name "*.lua" | wc -l)
        if [ "$lua_count" -gt 0 ]; then
            test_passed "Found $lua_count Lua configuration files"
        fi
    fi

    return $syntax_errors
}

test_plugin_manager() {
    print_test "Plugin manager"

    # Test plugin loading for lazy.nvim
    local plugin_test=$(timeout $TIMEOUT_MEDIUM nvim --headless -c "lua print('lazy_loaded:', require('lazy').stats().loaded)" -c "quit" 2>&1)
    if echo "$plugin_test" | grep -q "lazy_loaded:"; then
        local loaded_count=$(echo "$plugin_test" | grep -o "lazy_loaded: [0-9]*" | grep -o "[0-9]*")
        test_passed "Lazy.nvim loaded $loaded_count plugins"
    fi
}

test_lsp_setup() {
    print_test "LSP configuration"

    # Test LSP client availability
    local lsp_test=$(timeout $TIMEOUT_SHORT nvim --headless -c "lua print('lsp_available:', vim.lsp ~= nil)" -c "quit" 2>&1)
    if echo "$lsp_test" | grep -q "lsp_available: true"; then
        test_passed "LSP client available"

        # Test common LSP managers
        local lsp_managers=("mason" "lsp-installer" "lspconfig")
        for manager in "${lsp_managers[@]}"; do
            if timeout $TIMEOUT_SHORT nvim --headless -c "lua local ok = pcall(require, '$manager'); if ok then print('$manager:OK') end" -c "quit" 2>&1 | grep -q "$manager:OK"; then
                test_passed "LSP manager available: $manager"
                break
            fi
        done
    else
        test_warning "LSP client not configured" "No language servers available"
    fi
}

test_completion() {
    print_test "Completion engine"

    local completion_engines=("blink.cmp" "cmp" "ddc" "compe")
    local found_completion=""

    for engine in "${completion_engines[@]}"; do
        if timeout $TIMEOUT_SHORT nvim --headless -c "lua local ok = pcall(require, '$engine'); if ok then print('$engine:OK') end" -c "quit" 2>&1 | grep -q "$engine:OK"; then
            found_completion=$engine
            test_passed "Completion engine: $engine"
            break
        fi
    done

    if [ -z "$found_completion" ]; then
        test_warning "No completion engine detected" "Using built-in completion only"
    fi
}

test_startup_performance() {
    print_test "Startup performance"

    local startup_log=$(mktemp)
    if timeout $TIMEOUT_MEDIUM nvim --headless --startuptime "$startup_log" -c "quit" 2>/dev/null; then
        local startup_time=$(tail -1 "$startup_log" | awk '{print $1}')
        if [ -n "$startup_time" ]; then
            test_passed "Startup time: ${startup_time}s"

            # Performance warnings
            if awk "BEGIN {exit ($startup_time > 2.0) ? 0 : 1}"; then
                test_warning "Startup time >2s" "Consider optimizing plugin loading"
            elif awk "BEGIN {exit ($startup_time > 1.0) ? 0 : 1}"; then
                test_warning "Startup time >1s" "Performance could be improved"
            fi
        else
            test_failed "Could not measure startup time"
        fi
    else
        test_failed "Startup performance test failed"
    fi
    rm -f "$startup_log"
}

test_health_check() {
    print_test "Neovim health check"

    local health_output=$(timeout $TIMEOUT_LONG nvim --headless -c "checkhealth" -c "quit" 2>&1 || true)
    echo "$health_output"

    # Count errors and warnings
    local error_count=$(echo "$health_output" | grep -ci "error" || true)
    local warning_count=$(echo "$health_output" | grep -ci "warning" || true)

    if [ "$error_count" -eq 0 ]; then
        test_passed "Health check: no errors found"
    else
        test_failed "Health check: found $error_count errors" "Run ':checkhealth' for details"
    fi

    if [ "$warning_count" -gt 0 ]; then
        test_warning "Health check: found $warning_count warnings" "Run ':checkhealth' for details"
    fi
}

test_file_operations() {
    print_test "Basic file operations"

    local test_file=$(mktemp)
    echo "test content" > "$test_file"

    # Test file opening and editing
    if timeout $TIMEOUT_SHORT nvim --headless -c "edit $test_file" -c "normal! Goanother line" -c "write" -c "quit" 2>/dev/null; then
        if grep -q "another line" "$test_file"; then
            test_passed "File editing works correctly"
        else
            test_failed "File editing failed"
        fi
    else
        test_failed "Could not open and edit file"
    fi

    rm -f "$test_file"
}

echo -e "${BLUE}Neovim config validation${NC}"

test_nvim_installation
test_config_directory
test_basic_startup
test_lua_syntax
test_plugin_manager
test_lsp_setup
test_completion
test_startup_performance
test_file_operations
test_health_check

print_summary
