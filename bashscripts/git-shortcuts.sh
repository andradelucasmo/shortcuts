git-start() {

    # Setting personal information
    WORK_NAME="<your-work-name>"
    WORK_EMAIL="<your-work-email>"

    PERSONAL_NAME="<your-personal-name>"
    PERSONAL_EMAIL="<your-personal-email>"

    UNIVERSITY_NAME="<your-university-name>"
    UNIVERSITY_EMAIL="<your-university-email>"

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