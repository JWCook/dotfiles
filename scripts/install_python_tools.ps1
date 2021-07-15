# Install poetry
(Invoke-WebRequest -Uri https://raw.githubusercontent.com/python-poetry/poetry/master/install-poetry.py -UseBasicParsing).Content | python -
~\.poetry\bin\poetry.bat config virtualenvs.create false

# Install Windows-compatible virtualenvwrapper
# NOTE: Also set WORKON_HOME in system environment variables
pip install virtualenvwrapper-win
$Env:WORKON_HOME="$Env:USERPROFILE\.virtualenvs"
mkdir -Force $Env:WORKON_HOME
