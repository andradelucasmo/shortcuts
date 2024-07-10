# Index

- [Base Configuration](#base-configuration)
    - [Windows - Bash](#windows---bash)
- [Hello World Shortcuts](#hello-world-shortcuts)
    - [hello-world](#hello-world)
- [Git Shortcuts](#git-shortcuts)
    - [git-start-basic](#git-start-basic)
    - [git-add-config](#git-add-config)
    - [git-start-work](#git-start-work)

# Base Configuration

## Windows - Bash

1. Open Git Bash

2. Open `.bashrc`

Using Nano:

```bash
# Open script editor using nano
nano ~/.bashrc
```

OR

Using VS Code:

```bash
# Open script editor using Visual Studio Code
code ~/.bashrc
```

3. Add shortcuts

Remove `<your-path-to-bashscripts-shortcuts-folder>` and replace it with the absolute path to the folder that contains the bash shortcuts.

```bash
# Your previous bashrc code

# Define a variable for the folder path containing bash script shortcuts
BASH_SCRIPTS_FOLDER=<your-path-to-bashscripts-shortcuts-folder>
# Import all bash script shortcut files
for script in $BASH_SCRIPTS_FOLDER/*; do
    if [ -f "$script" ]; then
        echo "Importing $script" # You can remove this line after the first successful attempt
        . "$script"
    fi
done
```

4. Restart the bash terminal or source the .bashrc file

```bash
source ~/.bashrc
```

5. Try the test shortcut created in your terminal

```bash
hello-world
```

This should show the following response:

```
Hello World!
```

# Hello World Shortcuts

## hello-world

**Run:**

```bash
hello-world
```

**Result:**

You will see `Hello World!` in the bash terminal.

# Git Shortcuts

**Configuration**

1. Create an environment variables folder

Create a folder named env inside the shortcuts folder, and inside this folder, create a .sh file named git-shortcuts-env.sh.

OR

Open the bash on the shortcuts folder

```bash
mkdir -p env
touch env/git-shortcuts-env.sh
```

2. Insert the code below in the environment file

```bash
# Work information
WORK_NAME=""
WORK_EMAIL=""

# Personal information
PERSONAL_NAME=""
PERSONAL_EMAIL=""

# University information
UNIVERSITY_NAME=""
UNIVERSITY_EMAIL=""
```

## git-start-basic

**Run:**

```bash
git-start-basic
```

**Result:**

Configures the Git global settings, using PERSONAL_NAME and PERSONAL_EMAIL variables.

## git-add-config

**Run:**

```bash
# Replace <name>, <email> and <base_name> with the desired values
git-add-config <name> <email> <base_name>
```

**Result:**

Creates a file, if it does not exist, named .gitconfig_<base_name> with the Git configurations (name and email) provided in <name> and <email>.

Creates a folder, if it does not exist, named <base_name> in the home directory cd ~/<base_name>.

Updates .gitconfig to include the configurations in .gitconfig_<base_name> when you are inside the folder ~/<base_name>.

## git-start-work

**Run:**

```bash
git-start-work
```

**Result:**

Sets the default workstation config.

Configures the global Git settings using the WORK_* variables.

Creates two new .gitconfig_* files: one for personal Git settings using PERSONAL_* variables, and another for university Git settings using UNIVERSITY_* variables.

----