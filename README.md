# CONFIGURATION

#### Windows - Bash

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

----