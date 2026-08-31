#!/bin/bash

SESSION_NAME="hermes-mesh"

# Check if the tmux session already exists to prevent duplicates
tmux has-session -t $SESSION_NAME 2>/dev/null
if [ $? != 0  ]; then
    echo "🏗️ Constructing automated TMUX layout for Hermes & Herdr..."         
    # 1. Start a new detached TMUX session named 'hermes-mesh' (Window 0: Main Pane)
    tmux new-session -d -s $SESSION_NAME -n "Workspace"
    # 2. Split the window horizontally to create a bottom pane (30% height) for backend services
    tmux split-window -v -p 30 -t $SESSION_NAME:0.0
    # 3. Split that lower pane vertically to separate Ollama logs from Herdr control
    tmux split-window -h -p 50 -t $SESSION_NAME:0.1
    # 4. Populate Pane 0 (Top Main): Prepare for Hermes Agent or Code Editor
    tmux send-keys -t $SESSION_NAME:0.0 "clear && echo '🔮 MAIN WORKSPACE - Ready for Hermes Agent'" C-m
    # 5. Populate Pane 1 (Bottom Left): Ensure Ollama server daemon is active
    tmux send-keys -t $SESSION_NAME:0.1 "ollama serve" C-m
    # 6. Populate Pane 2 (Bottom Right): Launch Herdr foreground supervisor
    tmux send-keys -t $SESSION_NAME:0.2 "sleep 2 && herdr start" C-m
    # Select the top main pane as the active window focus
    tmux select-pane -t $SESSION_NAME:0.0
fi
# Attach the user directly to the running TMUX session environment
tmux attach-session -t $SESSION_NAME
