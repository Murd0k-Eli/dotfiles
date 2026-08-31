#!/usr/bin/env bash
# Bash Confguration File v0.01
# Author : Kumar

#---------------------------
#           PCT
#---------------------------
# Note that a variable may require special treatment
# if it will be exported.
#\e is a special character denoting the start of a color sequence
#\u indicates the name of the user, followed by the '@' symbol
#\h showcases the system's hostname
#\w indicates base directory
#\a represents an active directory
#$ represents a non-root user
#0 for standard text, 1 for bold, 3 for italic, and 4 for underlined text.
#The color range for background pallets is 40-47.
#The color range for text colors is 30-37.

DARKGRAY='\[\e[1;30m\]'
LIGHTRED='\[\e[1;31m\]'
GREEN='\[\e[32m\]'
YELLOW='\[\e[1;33m\]'
LIGHTBLUE='\[\e[1;34m\]'
NC='\[\e[m\]'

PCT="$(if [[ \$EUID -eq 0 ]]; then echo "$LIGHTRED"; else echo "$LIGHTBLUE"; fi)"

#  For "literal" command substitution to be assigned to a variable,
#+ use escapes and double quotes:
#+       PCT="\` ... \`" . . .
#  Otherwise, the value of PCT variable is assigned only once,
#+ when the variable is exported/read from .bash_profile,
#+ and it will not change afterwards even if the user ID changes.

#PS1="\n$GREEN[\w] \n$DARKGRAY($PCT\t$DARKGRAY)-($PCT\u$DARKGRAY)-($PCT\!
#$DARKGRAY)$YELLOW-> $NC"
PS1="$LIGHTBLUE\\u@\\h:$LIGHTRED\\w$NC$ "

#unset PROMPT_COMMAND
#unset PS0

#  Escape a variables whose value changes:
#        if [[ \$EUID -eq 0 ]],
#  Otherwise the value of the EUID variable will be assigned only once,
#+ as above.

#  When a variable is assigned, it should be called escaped:
#+       echo \$T,
#  Otherwise the value of the T variable is taken from the moment the PCT 
#+ variable is exported/read from .bash_profile.
#  So, in this example it would be null.

#  When a variable's value contains a semicolon it should be strong quoted:
#        T='$LIGHTRED',
#  Otherwise, the semicolon will be interpreted as a command separator.

#  Variables PCT and PS1 can be merged into a new PS1 variable:
#PS1="\`if [[ \$EUID -eq 0 ]]; then PCT='$LIGHTRED';
#else PCT='$LIGHTBLUE'; fi; 
#echo '\n$GREEN[\w] \n$DARKGRAY('\$PCT'\t$DARKGRAY)-\
#('\$PCT'\u$DARKGRAY)-('\$PCT'\!$DARKGRAY)$YELLOW-> $NC'\`"
#The trick is to use strong quoting for parts of old PS1 variable.

#---------------------------
#          TMUX
#---------------------------

# Launch Default Tmux Session on Terminal Launch
if command -v tmux &> /dev/null && [ -z "$TMUX" ]; then
    tmux attach-session -t default || tmux new-session -s default
fi

export LS_COLORS="di=1;33:fi=0;37:ln=1:or=5;31:mi=41;37:ex=1;92:*.c=0;36:*.cpp=0;36:*.py=0;32"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#------------------------------------
#              FUNCTIONS
#------------------------------------
dyk(){
    echo "Did you know that:"; whatis $(ls /bin | shuf -n 1 )
}
# Auto-glitch screen saver on terminal idle
# Set idle timeout in seconds (e.g., 180 seconds = 3 minutes)
#export TMOUT=180
#auto_glitch_screensaver() {
#    # Check if the terminal is interactive and the glitch script exists
#    if [[ -x "$HOME/Obsidian_vault/_bin/glitch.sh" ]]; then
#        # Launch the glitch script
#        "$HOME/Obsidian_vault/_bin/glitch.sh"
#        
#        # Once Ctrl+C exits the glitch script, restart a new Bash session 
#        # so the terminal window stays open and resets the idle timer
#        exec bash
#    fi
#}
# Trap the exit signal caused by the TMOUT variable timing out
#trap auto_glitch_screensaver EXIT

# Skip Commands when VSCode is detected!
if [ -z "$VSCODE_PID" ]; then
   # Add heavy commands here
   echo "Did you know that:"; whatis $(ls /bin | shuf -n 1 )
   . "$HOME/.local/bin/env"
fi

conda_init() {
    # !! Contents within this block are managed by 'conda init' !!
    __conda_setup="$('/home/kumar/anaconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "/home/kumar/anaconda3/etc/profile.d/conda.sh" ]; then
            . "/home/kumar/anaconda3/etc/profile.d/conda.sh"
        else
            export PATH="/home/kumar/anaconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
}

lazyupdate() {
    sudo apt update
    sudo apt upgrade -y
    sudo apt autoremove -y
    echo "System is fully updated and cleaned!"                   
}

alpine() {
    local container_name="alpine-virtual"
    # Check if the container exists
    if ! docker ps -a --format '{{.Names}}' | grep -Eq "^${container_name}$"; then
        echo "Error: Container '${container_name}' does not exist."
        return 1
    fi
    # Check if the container is currently running
    if docker ps --format '{{.Names}}' | grep -Eq "^${container_name}$"; then
        echo "Container '${container_name}' is already running."
        echo "Choose an option:"
        echo "1) Start a new session (exec into container)"
        echo "2) End the present one (stop container)"
        read -rp "Enter choice [1-2]: " choice

        case "$choice" in
            1)
                echo "Opening a new session..."
                docker exec -it "${container_name}" sh
                ;;
            2)
                echo "Stopping container..."
                docker stop "${container_name}"
                ;;
            *)
                echo "Invalid choice. Exiting."
                return 1
                ;;
        esac
    else
        echo "Container '${container_name}' is stopped. Starting and attaching..."
        docker start "${container_name}"
        docker attach "${container_name}"
    fi                                                                                 
}

#--------------------------------
#           ALIAS
#--------------------------------

alias ls='ls --color=auto --group-directories-first -v'
#alias vim='nvim'
#alias emacs='emacs -nw'
alias python='python3'

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

alias DB="cd ~/Media/Obsidian-Vault/_bin/_manDB/"
alias obsidian="cd ~/Media/Obsidian-Vault/"
alias condact="source ~/anaconda3/bin/activate"
alias condeact="conda deactivate"
#alias alpine="docker attach alpine-virtual"
alias sbash="source ~/.bashrc"
alias windows="/home/kumar/Apps/Windows/win-toggle.sh"

#---------------------------------
#               PATHS
#---------------------------------
export PATH="$HOME/anaconda3/bin:$PATH"
export JAVA_HOME="/usr/lib/jvm/java-21-openjdk-amd64"
# The -d flag checks if the directory actually exists
if [ -d "$JAVA_HOME" ]; then
    export PATH="$PATH:$JAVA_HOME/bin"
else
    echo "Java Path Enviornment not found!"
fi
export HERMES_ENABLE_PROJECT_PLUGINS=true


export ASTRA_DB_API_ENDPOINT="YOUR_API_ENDPOINT"
export ASTRA_DB_APPLICATION_TOKEN="YOUR_TOKEN"



# =============================================================================
# Hermes + Herdr + Ollama Mesh Status Monitoring
# =============================================================================
# Comprehensive health check for the entire agent mesh
alias hermes-check='echo "=== Checking Ollama Service ===" && curl -s http://127.0.0.1:11434 | grep -q "gemma4:31b-cloud" && echo "✅ Ollama: Online & gemma4:31b-cloud found" || echo "❌ Ollama: Offline or model missing" && echo "=== Checking Herdr Socket ===" && [ -S ~/.hermes/herdr.sock  ] && echo "✅ Herdr Socket: Active" || echo "⚠️ Herdr Socket: Not found (Start Hermes first)" && echo "=== Checking Hermes Config ===" && hermes config show | grep -E "herdr|ollama" && echo "✅ Hermes Config: Parsed"'
# Quick restart shortcut to apply YAML modifications instantly
alias hermes-reload='hermes config show && echo "🔄 Reloading agent context..." && herdr integration install hermes'


# =============================================================================
# Automated Herdr Agent Launch Sequence
# =============================================================================
if ! pgrep -x "herdr" > /dev/null; then
    echo "🤖 Launching Herdr orchestrator background service..."
    # Starts Herdr in background mode, routing logs safely away from your clean shell
    herdr start --daemon > /dev/null 2>&1 &
fi

# =============================================================================
# Automated TMUX Workspace Launch (Hermes + Herdr + Ollama)
# =============================================================================
# Only trigger if TMUX is installed, we are NOT already inside a tmux session, and the session is completely interactive.
if command -v tmux >/dev/null 2>&1 && [ -z "$TMUX"  ] && [ "$TERM" != "screen"  ]; then
    # Ensure our local bin directory is on the system path
    export PATH="$HOME/Media/Obsidian-Vault/_bin:$PATH"          
    # Execute the layout automator script instantly
    exec hermes-workspace.sh
fi
