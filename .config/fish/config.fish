set -g fish_key_bindings fish_vi_key_bindings 

atuin init fish | source
zoxide init fish | source

abbr --add cd z

set -gx EDITOR nvim

if status is-interactive

end


