# download and install znap if necessary
[[ -r ~/.zsh/plugins/marlonrichert/zsh-snap ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/.zsh/plugins/marlonrichert/zsh-snap
source ~/.zsh/plugins/marlonrichert/zsh-snap/znap.zsh

if ! command -v starship &>/dev/null; then
    curl -sS https://starship.rs/install.sh | sh
fi

zstyle ':znap:*' repos-dir ~/.zsh/plugins

# start starship
znap eval starship 'starship init zsh --print-full-init'
znap prompt

# pre-init for plugins
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)

# enable plugins
znap source ohmyzsh/ohmyzsh plugins/{git,common-aliases}
znap source marlonrichert/zsh-autocomplete
znap source zsh-users/zsh-syntax-highlighting
znap source zsh-users/zsh-completions
