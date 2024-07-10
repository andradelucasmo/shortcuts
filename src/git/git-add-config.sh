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
    CONFIG_FILE=".gitconfig_$BASE_NAME"

    # If the directory does not exist, create it and show a success message
    [ ! -d "$CONFIG_DIR" ] && mkdir -p "$CONFIG_DIR" && echo "* Created directory $CONFIG_DIR"

    # Generate the configuration file for the new config
    echo "* Configuring Git for $BASE_NAME"
    git config --file=$CONFIG_FILE --add user.name "$NAME"
    git config --file=$CONFIG_FILE --add user.email "$EMAIL"

    # Add new configuration to the .gitconfig file
    echo "* Updating global .gitconfig"
    git config --global --add includeif.gitdir:~/$BASE_NAME/.path $CONFIG_FILE

    # Store the current directory
    CURRENT_DIR=$(pwd)

    # Verify configuration in the new directory
    cd "$CONFIG_DIR"
    echo "* Verifying $BASE_NAME directory configuration"
    mkdir "$BASE_NAME-test-repo"
    cd "$BASE_NAME-test-repo"
    git init
    git config --list | grep user.name && git config --list | grep user.email
    cd ..
    rm -r "$BASE_NAME-test-repo"

    echo "* Git configuration for $BASE_NAME added successfully"

    # Return to the original directory
    cd "$CURRENT_DIR"
}