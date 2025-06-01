# pyenv

A quick and reliable way to have Python installed in macOS is `pyenv`, a Python
version manager that lets you easily install, switch between, and manage
multiple Python versions, `pyenv` needs to be installed with Homebrew:

```sh
brew install pyenv
```

After installing `pyenv` it will show some commands to add `pyenv` to the shell:
```sh
echo 'export PYENV_ROOT="$HOME/.pyenv"' >> ~/.zshrc
echo '[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"' >> ~/.zshrc
echo 'eval "$(pyenv init - zsh)"' >> ~/.zshrc
```

These commands adds this to the `.zshrc` file the `pyenv` initialization, this
could vary from system to system:
```
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"
```

Now that we have `pyenv` installed, we have to install a `Python` version and
make it available systemwide:
```sh
pyenv install 3.10.4
pyenv global 3.10.4
```

## Installation & Management

#### List available Python versions to install
```sh
pyenv install --list
```

#### Install a specific Python version
```sh
pyenv install 3.11.7
pyenv install 3.12.1
```

#### List installed versions
```sh
pyenv versions
```

#### Uninstall a version
```sh
pyenv uninstall 3.10.4
```

## Setting Python Versions

#### Set global default Python
```sh
pyenv global 3.11.7
```

#### Set Python version for current directory (creates .python-version file)
```sh
pyenv local 3.9.18
```

#### Set Python version for current shell session only
```sh
pyenv shell 3.12.1
```

#### Clear shell-specific version
```sh
pyenv shell --unset
```

## Checking Status

#### Show currently active Python version and where it's set
```sh
pyenv version
```

#### Show all versions and which is active (marked with *)
```sh
pyenv versions
```

#### Show which pyenv command would be executed
```sh
pyenv which python
pyenv which pip
```

### Practical Workflow

#### Typical project setup:
```sh
cd my-project/
pyenv local 3.11.7          # Sets Python version for this project
python -m venv venv         # Create virtual environment
source venv/bin/activate    # Activate it
pip install -r requirements.txt
```

#### Quick version switching:
```sh
pyenv global 3.11.7         # Most projects use this
cd legacy-project/
pyenv local 3.8.18          # This old project needs Python 3.8
cd ../new-experiment/
pyenv local 3.12.1          # Bleeding edge project
```

### Key Files

* `~/.python-version:` Global version setting
* `.python-version:` Local version setting (per directory)
* `~/.pyenv/versions/:` Where Python installations live

### Pro Tips

* Use `pyenv local` for project-specific versions
* The `.python-version` file should be committed to git so team members use the
  same Python version
* Always create virtual environments on top of pyenv-managed Python versions
* Update pyenv itself with `brew upgrade pyenv`

### Common Pattern
```sh
pyenv install 3.11.7        # Install Python version
cd myproject/
pyenv local 3.11.7          # Set for this project
python -m venv venv         # Create isolated environment
source venv/bin/activate    # Activate environment
pip install package-name    # Install packages safely
```

This gives you reproducible, isolated Python environments per project while
keeping your system clean.RetryClaude does not have the ability to run the code
it generates yet.Claude can make mistakes. Please double-check responses.
