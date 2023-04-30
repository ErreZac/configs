if status is-interactive
    # Commands to run in interactive sessions can go here
    set -g theme_color_scheme terminal-dark

    source /home/zac/Scripts/aliases.sh
    source /home/zac/Scripts/bashedits.sh
    export _JAVA_AWT_WM_NONREPARENTING=1
    pyenv init - | source
    fish_vi_key_bindings
    # set -g theme_color_scheme "terminal-light"
    # set -g theme_color_scheme "gruvbox"
    set -g theme_color_scheme terminal2-dark-black
    starship init fish | source
end

