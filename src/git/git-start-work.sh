SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/.env.sh"

# Setting variables for the personal, university and work folders
PERSONAL_DIR="$HOME/$PERSONAL_FILE"
UNIVERSITY_DIR="$HOME/$UNIVERSITY_FILE"
WORK_DIR="$HOME/$WORK_FILE"

# Setting variables for the configuration paths
GITCONFIG_PERSONAL_FILE=".gitconfig_$PERSONAL_FILE"
GITCONFIG_UNIVERSITY_FILE=".gitconfig_$UNIVERSITY_FILE"
GITCONFIG_WORK_FILE=".gitconfig_$WORK_FILE"

git-start-work() {
    CURRENT_DIR=$(pwd)

    # Create folder to personal workspace and configure personal gitconfig
    [ ! -d "$PERSONAL_DIR" ] && mkdir -p "$PERSONAL_DIR" && echo "* Created directory $PERSONAL_DIR"
    configure_git_directory "$PERSONAL_FILE" "$GITCONFIG_PERSONAL_FILE" "$PERSONAL_NAME" "$PERSONAL_EMAIL"

    # Create folder to university workspace and configure university gitconfig
    [ ! -d "$UNIVERSITY_DIR" ] && mkdir -p "$UNIVERSITY_DIR" && echo "* Created directory $UNIVERSITY_DIR"
    configure_git_directory "$UNIVERSITY_FILE" "$GITCONFIG_UNIVERSITY_FILE" "$UNIVERSITY_NAME" "$UNIVERSITY_EMAIL"

    # Create folder to workspace and configure work gitconfig
    [ ! -d "$WORK_DIR" ] && mkdir -p "$WORK_DIR" && echo "* Created directory $WORK_DIR"
    configure_git_directory "$WORK_FILE" "$GITCONFIG_WORK_FILE" "$WORK_NAME" "$WORK_EMAIL"

    echo "* Git configurations added successfully"
    cd "$CURRENT_DIR"
}

configure_git_directory() {
    local DIR_NAME=$1
    local CONFIG_FILE=$2
    local USER_NAME=$3
    local USER_EMAIL=$4

    cd "$HOME"

    # Generate the configuration file for the new directory
    echo "* Configuring Git for $DIR_NAME directory"
    git config --file=$CONFIG_FILE --add user.name "$USER_NAME"
    git config --file=$CONFIG_FILE --add user.email "$USER_EMAIL"

    # Add new directory configuration to the .gitconfig file
    echo "* Updating global .gitconfig"
    git config --global --add includeif.gitdir:~/$DIR_NAME/.path $CONFIG_FILE

    # Verify configuration in the new work directory
    cd "$HOME/$DIR_NAME"
    echo "* Verifying work ~/$DIR_NAME directory configuration"
    mkdir "$DIR_NAME-test-repo"
    cd "$DIR_NAME-test-repo"
    git init
    git config --list | grep user.name && git config --list | grep user.email
    cd ..
    rm -r "$DIR_NAME-test-repo"
}