#!/usr/bin/env bash
# auto-cpufreq install script, modified from:
# https://github.com/AdnanHodzic/auto-cpufreq/blob/master/auto-cpufreq-installer
set -o nounset
cd "$(dirname "$(readlink -f "$0")")" || exit 1

COLOUMNS="`tput cols`"
MID="$((COLOUMNS / 2))"

APPLICATIONS_PATH="/usr/share/applications"
REPO_DIR="/usr/local/src/auto-cpufreq"
REPO_URL="https://github.com/AdnanHodzic/auto-cpufreq.git"
SHARE_DIR="/usr/local/share/auto-cpufreq/"
VENV_DIR="/opt/auto-cpufreq/venv"

AUTO_CPUFREQ_FILE="/usr/local/bin/auto-cpufreq"
AUTO_CPUFREQ_GTK_FILE=$AUTO_CPUFREQ_FILE-gtk
AUTO_CPUFREQ_GTK_DESKTOP_FILE="$(basename $AUTO_CPUFREQ_GTK_FILE).desktop"

IMG_FILE="/usr/share/pixmaps/auto-cpufreq.png"
ORG_FILE="/usr/share/polkit-1/actions/org.auto-cpufreq.pkexec.policy"


function header {
  echo
  printf "%0.s─" $(seq $((MID-(${#1}/2)-2)))
  printf " $1 "
  printf "%0.s─" $(seq $((MID-(${#1}/2)-2)))
  echo; echo
}

function ask_operation {
  header "auto-cpufreq installer"
  echo "Welcome to auto-cpufreq tool installer."; echo
  read -p "Select a key [I]nstall/[R]emove or press ctrl+c to quit: " answer
}

function manual_install {
  if command -v lsb_release > /dev/null; then
    distro="$(lsb_release -is)"
    release="$(lsb_release -rs)"
    codename="$(lsb_release -cs)"
  fi
  echo "Didn't detect Debian or RedHat or Arch based distro."; exit 1
}

function tool_install {

  # Clone or update repo
  git -C $REPO_DIR pull 2> /dev/null || git clone --depth 1 $REPO_URL $REPO_DIR
  cd $REPO_DIR

  echo
  # First argument is the distro
  function detected_distro {
    header "Detected $1 distribution"
    header "Setting up Python environment"
  }

  if [ -f /etc/debian_version ]; then
    detected_distro "Debian based"
    apt install python3-dev python3-pip python3-venv python3-setuptools dmidecode libgirepository1.0-dev libcairo2-dev libgtk-3-dev gcc -y

  elif [ -f /etc/redhat-release ]; then
    detected_distro "RedHat based"
    if [ -f /etc/centos-release ]; then yum install platform-python-devel
    else yum install python-devel
    fi
    yum install dmidecode gcc cairo-devel gobject-introspection-devel cairo-gobject-devel gtk3-devel

  elif [ -f /etc/arch-release ]; then
    detected_distro "Arch Linux based"
    pacman -S --noconfirm --needed python python-pip python-setuptools base-devel dmidecode gobject-introspection gtk3 gcc

elif [ -f /etc/os-release ];then
    . /etc/os-release
    case $ID in
      opensuse-leap)
        detected_distro "OpenSUSE"
        zypper install -y python3 python3-pip python311-setuptools python3-devel gcc dmidecode gobject-introspection-devel python3-cairo-devel gtk3 gtk3-devel
      ;;
      opensuse-tumbleweed)
        detected_distro "OpenSUSE"
        zypper install -y python3 python3-pip python311-setuptools python3-devel gcc dmidecode gobject-introspection-devel python3-cairo-devel gtk3 gtk3-devel
      ;;
      void)
        detected_distro "Void Linux"
        xbps-install -Sy python3 python3-pip python3-devel python3-setuptools base-devel dmidecode cairo-devel gobject-introspection gcc gtk+3
      ;;
      nixos)
        echo "NixOS detected"
        echo "This installer is not supported on NixOS."
        echo "Please refer to the install instructions for NixOS at https://github.com/AdnanHodzic/auto-cpufreq#nixos"
        exit 1
      ;;
      *) manual_install;;
    esac
  else # In case /etc/os-release doesn't exist
    manual_install
  fi

  header "Installing necessary Python packages"

  mkdir -p "$VENV_DIR"
  python3 -m venv "$VENV_DIR"

  source "$VENV_DIR/bin/activate"
  python3 -m pip install --upgrade pip wheel

  header "Installing auto-cpufreq tool"

  git config --global --add safe.directory $(pwd)
  python -m pip install .

  mkdir -p $SHARE_DIR
  cp -r scripts/ $SHARE_DIR
  cp -r images/ $SHARE_DIR
  cp images/icon.png $IMG_FILE
  cp scripts/$(basename $ORG_FILE) $(dirname $ORG_FILE)

  # this is necessary since we need this script before we can run auto-cpufreq itself
  cp scripts/auto-cpufreq-venv-wrapper $AUTO_CPUFREQ_FILE
  chmod a+x $AUTO_CPUFREQ_FILE
  cp scripts/start_app $AUTO_CPUFREQ_GTK_FILE
  chmod a+x $AUTO_CPUFREQ_GTK_FILE

  desktop-file-install --dir=$APPLICATIONS_PATH scripts/$AUTO_CPUFREQ_GTK_DESKTOP_FILE
  update-desktop-database $APPLICATIONS_PATH

  header "installing daemon"
  $AUTO_CPUFREQ_FILE --install
  header "auto-cpufreq tool successfully installed"
}

function tool_remove {

  # stop any running auto-cpufreq argument (daemon/live/monitor)
  tool_arg_pids=($(pgrep -f "auto-cpufreq --"))
  for pid in "${tool_arg_pids[@]}"; do [ $pid != $$ ] && kill "$pid"; done

  function remove_directory {
    [ -d $1 ] && rm -rf $1
  }
  function remove_file {
    [ -f $1 ] && rm $1
  }

  srv_remove="$AUTO_CPUFREQ_FILE-remove"

  # run uninstall in case of installed daemon
  if [ -f $srv_remove -o -f $AUTO_CPUFREQ_FILE ]; then
    eval "$AUTO_CPUFREQ_FILE --remove"
  else
    echo; echo "Couldn't remove the auto-cpufreq daemon, $srv_remove do not exist."
  fi

  # remove auto-cpufreq and all its supporting files
  remove_directory $REPO_DIR
  remove_directory $SHARE_DIR

  remove_file "$AUTO_CPUFREQ_FILE-install"
  remove_file $srv_remove
  remove_file $AUTO_CPUFREQ_FILE
  remove_file $AUTO_CPUFREQ_GTK_FILE
  remove_file $IMG_FILE
  remove_file $ORG_FILE
  remove_file "/usr/local/bin/cpufreqctl.auto-cpufreq"
  remove_file "/var/run/auto-cpufreq.stats"

  remove_file "$APPLICATIONS_PATH/$AUTO_CPUFREQ_GTK_DESKTOP_FILE"
  update-desktop-database $APPLICATIONS_PATH

  # remove python virtual environment
  remove_directory $VENV_DIR

  echo; echo "auto-cpufreq tool and all its supporting files successfully removed"; echo
}

# root check
if ((EUID != 0)); then
  echo; echo "Must be run as root (i.e: 'sudo $0')."; echo
  exit 1
fi

if [[ -z "$1" ]]; then ask_operation
else
  case "$1" in
    --install) answer="i";;
    --remove) answer="r";;
    *) ask_operation;;
  esac
fi

case $answer in
  I|i) tool_install;;
  R|r) tool_remove;;
  *)
    echo "Unknown key, aborting ..."; echo
    exit 1
  ;;
esac
