set -g fish_key_bindings fish_vi_key_bindings 

bind --mode default y backward-char
bind --mode default l forward-word  
bind --mode default e forward-char
bind --mode default j repaint-mode -m insert
bind --mode default J beginning-of-line repaint-mode -m insert

bind --mode default "''" kill-whole-line yank 
bind --mode default "'",w kill-word yank 
bind --mode default "'",b forward-single-char backward-kill-word yank 
bind --mode default "'",\$ kill-line yank 
bind --mode default "'",i,w forward-single-char forward-single-char backward-word kill-word yank
bind --mode default "'",a,w forward-single-char forward-single-char backward-bigword kill-bigword yank
bind --mode default "'",i,b jump-till-matching-bracket and jump-till-matching-bracket and begin-selection jump-till-matching-bracket kill-selection yank end-selection
bind --mode default "'",a,b jump-to-matching-bracket and jump-to-matching-bracket and begin-selection jump-to-matching-bracket kill-selection yank end-selection

bind --mode visual l forward-word
bind --mode visual y backward-char
bind --mode visual e forward-char
bind --mode visual "'" -m default kill-selection yank fish_clipboard_copy end-selection repaint-mode

fzf --fish | source

atuin init fish | source
zoxide init fish | source

fish_add_path /home/gutswright/.cargo/bin/

# abbr --add cd z
# alias ls="eza --icons=auto --group-directories-first"
abbr --add tree "lsd --tree"
alias ls="lsd"


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


