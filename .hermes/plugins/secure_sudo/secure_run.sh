    #!/usr/bin/env bash
    #!/usr/bin/env bash

# 1. Capture the targeted command
TARGET_COMMAND="$@"

if [ -z "$TARGET_COMMAND" ]; then
    echo "Error: No command specified to run with sudo." >&2
    exit 1
fi

# 2. STRIP DANGEROUS SHELL OPERATORS (Prevents Command Injection)
# Blocks attempts to bypass validations via chaining lines: command1; command2
if [[ "$TARGET_COMMAND" =~ [\;\|\&\>\<\`\$] ]]; then
    echo "Security Error: Shell operators (; | & > < \` $) are forbidden in secure_sudo." >&2
    exit 126
fi

# 3. EXTRACT THE PRIMARY BINARY (The first word of the command string)
# e.g., if command is "apt-get upgrade -y", PRIMARY_BIN becomes "apt-get"
PRIMARY_BIN=$(echo "$TARGET_COMMAND" | awk '{print $1}')

# Resolve symbolic links or aliases to find the actual system path
REAL_PATH=$(which "$PRIMARY_BIN" 2>/dev/null)
if [ -z "$REAL_PATH" ]; then
    echo "Error: Command binary '$PRIMARY_BIN' not found in PATH." >&2
    exit 127
fi

# 4. DEFINE FORBIDDEN EXECUTABLES (The Absolute Denylist)
# Add any commands the AI should never be allowed to execute via root elevation.
RESTRICTED_BINS=(
    "/usr/bin/passwd"      # Changing user passwords
    "/usr/bin/rm"          # System file destruction
    "/usr/bin/dd"          # Direct block device overwrites
    "/usr/bin/chmod"       # Manual cluster-wide security manipulation
    "/usr/sbin/visudo"     # Modifying sudoers architecture permissions
    "/usr/bin/bash"        # Dropping into an untracked root shell
    "/usr/bin/sh"          # Dropping into an alternate root shell
    "/usr/bin/su"          # User context hopping
)

# Cross-reference the resolved binary pathway against the denylist array
for RESTRICTED in "${RESTRICTED_BINS[@]}"; do
    if [ "$REAL_PATH" = "$RESTRICTED" ]; then
        echo "Security Policy Failure: Root access to '$PRIMARY_BIN' ($REAL_PATH) is blacklisted." >&2
        exit 126
    fi
done

# 2. Prompt Hermes securely for the temp password (input hidden)
read -s -p "[sudo] enter temporary password: " TEMP_PASS
echo "" # Move to a new line after hidden prompt input
    
# 3. Stream the password to sudo and capture execution status
# -S forces sudo to read from standard input rather than the terminal
echo "$TEMP_PASS" | sudo -S $TARGET_COMMAND
EXIT_CODE=$?
    
# 4. Burn the password immediately from script memory
unset TEMP_PASS
    
# 5. Forcefully destroy the sudo cache timestamp for this process 
sudo -k
    
# 6. Exit with the command's original termination code
exit $EXIT_CODE
