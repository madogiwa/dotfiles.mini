
# check current directory
if [ ! -e install.sh ]; then
    echo "install.sh not found."
    exit 1
fi

dotfiles=(
  ".bashrc"
  ".bash_profile"
  ".inputrc"
  ".screenrc"
  ".my.cnf"
  ".vimrc"
)

# link dotfiles
for file in "${dotfiles[@]}"; do
    ln -snf `pwd`/$file $HOME/$file
done

