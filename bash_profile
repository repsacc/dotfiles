[[ -s ~/.bashrc ]] && source ~/.bashrc

if [[ "$TERM" != "screen-256color" ]]; then
    exec tmux -S /var/tmux/$USER new-session -A -s "$USER"
fi
