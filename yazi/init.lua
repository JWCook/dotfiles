th.git = th.git or {}

th.git.added_sign = ""
th.git.deleted_sign = ""
th.git.ignored_sign = ""
th.git.modified_sign = ""
th.git.untracked_sign = "?"
th.git.updated_sign = ""

th.git.added = ui.Style():fg("green")
th.git.deleted = ui.Style():fg("red")
th.git.ignored = ui.Style():fg("darkgray")
th.git.modified = ui.Style():fg("yellow")
th.git.untracked = ui.Style():fg("magenta")
th.git.updated = ui.Style():fg("yellow")

require("full-border"):setup()
require("git"):setup()

-- When 25.9.15+ is released
-- require("piper"):setup()
