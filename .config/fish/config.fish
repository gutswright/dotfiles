set -g fish_key_bindings fish_vi_key_bindings
 
atuin init fish | source
zoxide init fish | source

abbr --add cd z

if status is-interactive
    # Commands to run in interactive sessions can go here
end
