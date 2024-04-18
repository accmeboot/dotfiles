echo "Creating ~/.zsh directory"
if [ ! -d "~./zsh" ]; then
  mkdir ~/.zsh
else
  echo "~/.zsh directory already exists"
fi

echo "Adding nv and kitten icat aliases  to ~/.zshrc"
echo "alias nv='nvim'" >> ~/.zshrc
echo "alias icat='kitten icat'" >> ~/.zshrc

echo "Changing ZSH_THEME to dst"
sed -i -e 's/ZSH_THEME=".*"/ZSH_THEME="dst"/' ~/.zshrc

echo "Cloning zsh-autosuggestions and zsh-syntax-highlighting"
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

echo "Source plugins in ~/.zshrc"
echo "source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ~/.zshrc
echo "source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh" >> ~/.zshrc

echo "Adding neofetch to ~/.zshrc"
echo "neofetch" >> ~/.zshrc

echo "Installing oh-my-zsh"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
