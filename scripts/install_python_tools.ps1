# Install poetry
Invoke-WebRequest -Uri https://install.python-poetry.org -OutFile install-poetry.py
python install-poetry.py --preview
~\AppData\Roaming\Python\Scripts\poetry.exe config virtualenvs.create false

# Install Windows-compatible virtualenvwrapper
# NOTE: Also set WORKON_HOME in system environment variables
pip install virtualenvwrapper-win
$Env:WORKON_HOME="$Env:USERPROFILE\.virtualenvs"
mkdir -Force $Env:WORKON_HOME
