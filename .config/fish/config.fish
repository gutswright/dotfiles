set -g fish_key_bindings fish_vi_key_bindings 

bind -M default y backward-char
bind -M default l forward-word  
bind -M default e forward-char
bind -M default j repaint-mode -m insert
bind -M default J beginning-of-line repaint-mode -m insert

bind -M default "''" kill-whole-line yank 
bind -M default "'",w kill-word yank 
bind -M default "'",b forward-single-char backward-kill-word yank 
bind -M default "'",\$ kill-line yank 
bind -M default "'",i,w forward-single-char forward-single-char backward-word kill-word yank
bind -M default "'",a,w forward-single-char forward-single-char backward-bigword kill-bigword yank
bind -M default "'",i,b jump-till-matching-bracket and jump-till-matching-bracket and begin-selection jump-till-matching-bracket kill-selection yank end-selection
bind -M default "'",a,b jump-to-matching-bracket and jump-to-matching-bracket and begin-selection jump-to-matching-bracket kill-selection yank end-selection

bind -M visual l forward-word
bind -M visual y backward-char
bind -M visual e forward-char
bind -M visual "'" -m default kill-selection yank fish_clipboard_copy end-selection repaint-mode

fzf --fish | source

zoxide init fish | source

fish_add_path /home/gutswright/.cargo/bin/

set -gx ATUIN_NOBIND true
atuin init fish | source

# Manually bind atuin keys (without deprecated -k flag)
bind \cr _atuin_search
bind -M insert \cr _atuin_search
bind \eOA _atuin_bind_up
bind \e\[A _atuin_bind_up
bind -M insert \eOA _atuin_bind_up
bind -M insert \e\[A _atuin_bind_up

# abbr --add cd z
alias ls="eza --icons=auto --group-directories-first"
abbr --add tree "lsd --tree"

# alias ls="lsd"
alias firefoxd="firefox-developer-edition"
alias code="code --enable-features=UseOzonePlatform  --ozone-platform=wayland"
alias steam='env SDL_VIDEODRIVER=wayland GDK_BACKEND=wayland QT_QPA_PLATFORM=wayland DISPLAY=:0 steam'
alias ls="eza --icons=auto --group-directories-first"
alias vimlab="matlab -nodesktop -nosplash" 
alias fontforge="GDK_SCALE=2 fontforge -nosplash"
alias gam="/home/gutswright/bin/gam7/gam"


set -gx EDITOR nvim

set -U fish_user_paths /opt/google-cloud-cli/bin $fish_user_paths

bind \co ranger-cd

function fish_greeting 
    random choice 'And remember, you are great coder because of your perseverance!' 'You are great' '1. Stand up straight with your shoulders back' "To stand up straight with your shoulders back is to accept the terrible responsibility of life, with eyes wide open. It means deciding to voluntarily transform the chaos of potential into the realities of habitable order." '2. Treat yourself like someone you are responsible for helping' "You should take care of, help, and be good to yourself the same way you would take care of, help, and be good to someone you loved and valued." '3. Make friends with people who want the best for you' "If you surround yourself with people who support your upward aim, they will not tolerate your cynicism and destructiveness." '4. Compare yourself to who you were yesterday, not to who someone else is today' "Aim up. Pay attention to your footing. Forget the damned comparisons." '5. Do not let your children do anything that makes you dislike them' "Children must be shaped, or they cannot thrive." '6. Set your house in perfect order before you criticize the world' "Sort yourself out." '7. Pursue what is meaningful (not what is expedient)' "Meaning trumps expediency." "8. Tell the truth—or, at least, don\'t lie" "Speak the truth. Or at least don\'t lie." "9. Assume that the person you are listening to might know something you don\'t" "Listen carefully. Talk over people less." '10. Be precise in your speech' "If you say what you truly think, you can learn something." '11. Do not bother children when they are skateboarding' "This rule is about letting young people take calculated risks, and not over protecting them." '12. Pet a cat when you encounter one on the street' "When faced with chaos, you can bring order. If you cannot bring order to the chaos that confronts you, you can still bring order to yourself."
end

function fish_title
    # set -q argv[1]; or set argv fish
    # Looks like ~/d/fish: git log
    # or /e/apt: fish
    echo (fish_prompt_pwd_dir_length=1 prompt_pwd): $argv;
end
function fish_mode_prompt
  switch $fish_bind_mode
    case default
      set_color --bold red
      random choice '🐬 ' '🐟 ' '🐳 ' '🐋 ' '🌊 ' '🎣 ' '⚓ ' '🌊 ' '🧊 ' '🌀 '
    case insert
      set_color --bold green
      random choice '🏮 ' '⛵ ' '🪸 ' '🦐 ' '🦀 ' '🦞 ' '🦑 ' '🐙 '
    case replace_one 
      set_color --bold green
      random choice '🦈 '  '🥥 '
    case visual
      set_color --bold brmagenta
      random choice '🧭 ' '🦦 ' '🦭 '
    case '*'
      set_color --bold red
      random choice '🐡 ' '🐠 ' '🛶 '
  end # Added this line to close the switch statement
  set_color normal
end 
if status is-interactive

end


# # directories
# alias ..="cd .." \
#       ...="cd ../.." \
#       ....="cd ../../.." \
#       .....="cd ../../../.." \
#       ......="cd ../../../../.."


