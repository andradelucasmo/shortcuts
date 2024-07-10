git-start() {
    echo -e "* Defining global user name"
    git config --global user.name "Andrade"
    echo -e "* Defining global user email"
    git config --global user.email "andradelucasmo@gmail.com"
    echo -e "* Git configuration info"
    git config --list
}