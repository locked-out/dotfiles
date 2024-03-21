
# function fish_prompt
#     printf '%s@%s %s%s%s > ' $USER $hostname (set_color $fish_color_cwd) (prompt_pwd) (set_color normal)
# end

if status is-interactive
    # set fish_function_path $fish_function_path "usr/share/powerline/bindings/fish"
    # source /usr/share/powerline/bindings/fish/powerline-setup.fish
    # powerline-setup
  set -g fish_greeting

  alias gdb="gdb -tui -q"

  set -gx EDITOR /usr/bin/nvim

  # for coloured man pages
  set -xU MANPAGER 'less -R --use-color -Dd+b -Du+c'
  set -xU MANROFFOPT '-P -c'

  starship init fish | source
end

