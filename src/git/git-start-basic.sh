SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/.env.sh"

git-start-basic() {
    git config --global user.name "$PERSONAL_NAME"
    git config --global user.email "$PERSONAL_EMAIL"
}