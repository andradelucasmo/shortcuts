# Import enviroment variables
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/gitconfig-env.sh"

git-start-basic() {
    git config --global user.name="$PERSONAL_NAME"
    git config --global user.email="$PERSONAL_EMAIL"
}

git-add-config() {
    # Verify if the three parameters are included
    if [ "$#" -ne 3 ]; then
        echo "Usage: git-add-config <name> <email> <base_name>"
        return 1
    fi

    # Setting inserted information
    NAME="$1"
    EMAIL="$2"
    BASE_NAME="$3"

    # Setting directory and file names
    CONFIG_DIR="$HOME/$BASE_NAME"
    CONFIG_FILE="$HOME/.gitconfig_$BASE_NAME"

    # If the directory does not exist, create it and show a success message
    [ ! -d "$CONFIG_DIR" ] && mkdir -p "$CONFIG_DIR" && echo "* Created directory $CONFIG_DIR"

    # Generate the configuration file for the new config
    echo "* Configuring Git for $BASE_NAME"
    cat > "$CONFIG_FILE" <<EOL
[user]
    name = "$NAME"
    email = "$EMAIL"
EOL

    # Add new configuration to the .gitconfig file
    echo "* Updating global .gitconfig"
    {
        echo
        echo "[includeIf \"gitdir:$CONFIG_DIR/\"]"
        echo "    path = $CONFIG_FILE"
    } >> "$HOME/.gitconfig"

    echo "* Git configuration for $BASE_NAME added successfully"

    # Store the current directory
    CURRENT_DIR=$(pwd)

    # Verify configuration in the new directory
    cd "$CONFIG_DIR"
    echo "* Verifying $BASE_NAME directory configuration"
    mkdir "$BASE_NAME-test-repo"
    cd "$BASE_NAME-test-repo"
    git config --list | grep user.name && git config --list | grep user.email
    cd ..
    rm -r "$BASE_NAME-test-repo"

    # Return to the original directory
    cd "$CURRENT_DIR"
}

git-start-work() {
    # Setting variables for the personal and university folders
    PERSONAL_DIR="$HOME/lucas"
    UNIVERSITY_DIR="$HOME/university"

    # Setting variables for the configuration paths
    PERSONAL_CONFIG="$HOME/.gitconfig_lucas"
    UNIVERSITY_CONFIG="$HOME/.gitconfig_university"

    # If the directories do not exist, create them and show a success message
    [ ! -d "$PERSONAL_DIR" ] && mkdir -p "$PERSONAL_DIR" && echo "* Created directory $PERSONAL_DIR"
    [ ! -d "$UNIVERSITY_DIR" ] && mkdir -p "$UNIVERSITY_DIR" && echo "* Created directory $UNIVERSITY_DIR"

    # Generate the configuration file for the personal directory
    echo "* Configuring Git for personal directory"
    cat > "$PERSONAL_CONFIG" <<EOL
[user]
    name = "$PERSONAL_NAME"
    email = "$PERSONAL_EMAIL"
EOL

    # Generate the configuration file for the university directory
    echo "* Configuring Git for university directory"
    cat > "$UNIVERSITY_CONFIG" <<EOL
[user]
    name = "$UNIVERSITY_NAME"
    email = "$UNIVERSITY_EMAIL"
EOL

    # Update .gitconfig to import the new files
    echo "* Updating global .gitconfig"
    cat > "$HOME/.gitconfig" <<EOL
[user]
    name = "$WORK_NAME"
    email = "$WORK_EMAIL"

[includeIf "gitdir:$PERSONAL_DIR/"]
    path = $PERSONAL_CONFIG

[includeIf "gitdir:$UNIVERSITY_DIR/"]
    path = $UNIVERSITY_CONFIG
EOL

    echo "* Git configuration completed successfully"
    # Store the current directory
    CURRENT_DIR=$(pwd)

    # Verify configuration in the personal directory
    cd "$PERSONAL_DIR"
    echo "* Verifying personal directory configuration"
    mkdir personal-test-repo
    cd personal-test-repo
    git config --list | grep user.name && git config --list | grep user.email
    cd ..
    rm -r personal-test-repo

    # Verify configuration in the university directory
    cd "$UNIVERSITY_DIR"
    echo "* Verifying university directory configuration"
    mkdir university-test-repo
    cd university-test-repo
    git config --list | grep user.name && git config --list | grep user.email
    cd ..
    rm -r university-test-repo

    # Return to the original directory
    cd "$CURRENT_DIR"
}