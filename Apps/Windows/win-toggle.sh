#!/bin/bash
# Configuration Variables
CONTAINER_NAME="windows"
RDP_USER="Docker"
RDP_PASS="StrongPassword123!"
RDP_PORT="3389"

launch_rdp() {
    echo "🖥️ Launching FreeRDP session..."
    xfreerdp3 /v:localhost:"$RDP_PORT" \
        /u:"$RDP_USER" \
        /p:"$RDP_PASS" \
        /cert:ignore \
        /log-level:OFF \
        +f \
        +clipboard \
        +dynamic-resolution \
        /network:lan \
        /audio-mode:0
    return $?
}

manage_rdp_session(){
    while true; do
        launch_rdp
        STATUS=$?
        # Check if the last command executed successfully (exit code 0)
        if [ $STATUS -eq 0 ] || [ $STATUS -eq 130 ]; then
            echo "✅ Session closed normally by the user. Exiting."
            break
#        elif [ $STATUS -eq 127 ]; then
#            echo "🛑 Exit Code 127 detected."
#            echo "Shutting down the Windows container safely..."
#            docker stop "$CONTAINER_NAME"
#            echo "✅ Windows has been shut down safely."
#            break
        else
            echo "⚠️ Connection dropped or Windows is not ready yet."
            echo "(Exit Code: $STATUS). Retrying in 3 seconds..."
            echo "----------------------------------------"
            read -p "Would you like to try reconnecting? (y/n): " RETRY
            echo "----------------------------------------"            
            if [[ ! "$RETRY" =~ ^[Yy]$ ]]; then
                echo "❌ Exiting connection loop."
                break
            fi
            sleep 3
            echo "⏳ Retrying connection..."
        fi
    done
}
# 1. Action if the container is ALREADY running
if docker ps --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "💡 Windows container is already running."
    echo "----------------------------------------"
    echo "1) Start a fresh FreeRDP session"
    echo "2) Close the container safely"
    echo "3) Cancel and exit"
    echo "----------------------------------------"
    read -p "Select an option (1-3): " CHOICE
    case "$CHOICE" in
        1)
            manage_rdp_session
            exit 0
            ;;
        2)
            echo "🔄 Closing Windows container safely..."
            docker stop "$CONTAINER_NAME"
            echo "✅ Windows has been shut down safely."
            exit 0
            ;;
        *)
            echo "❌ Cancelled."
            exit 0
            ;;
    esac
fi
# 2. If container exists but is stopped, start it. Otherwise, run a new one.
if docker ps -a --format '{{.Names}}' | grep -q "^${CONTAINER_NAME}$"; then
    echo "🚀 Starting existing Windows container..."
    docker start "$CONTAINER_NAME"
else
    echo "📦 Creating and launching a fresh Windows container..."
    docker run -d \
      --name "$CONTAINER_NAME" \
      -p 8006:8006 \
      -p ${RDP_PORT}:${RDP_PORT}/tcp \
      -p ${RDP_PORT}:${RDP_PORT}/udp \
      --device=/dev/kvm \
      dockurr/windows
fi
# 3. Wait for the Windows RDP network service to come online
echo "⏳ Waiting for Windows RDP port to respond (this takes a moment)..."
while ! nc -z localhost "$RDP_PORT" 2>/dev/null; do
    sleep 120
done
echo "⏳ Port detected open. Stabilising connection handshake..."
sleep 12
echo "🖥️ Launching FreeRDP login..."
# 4. Automate the logon with FreeRDP
manage_rdp_session
