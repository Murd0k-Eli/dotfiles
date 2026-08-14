import os
import json
import subprocess
from pathlib import Path

# Extract the absolute path of the accompanying bash script file
SCRIPT_PATH = str(Path(__file__).parent / "secure_run.sh")

def handle_secure_sudo(args: dict, **kwargs) -> str:
    """Invokes the custom secure sudo script and returns execution output as JSON."""
    command_to_run = args.get("command")
    if not command_to_run:
        return json.dumps({"success": False, "error": "No command argument passed."})
    
    try:
        # Launch the bash wrapper script inside a simulated interactive PTY subprocess environment
        result = subprocess.run(
            [SCRIPT_PATH, command_to_run],
            text=True,
            capture_output=True,
            check=False
        )
        
        return json.dumps({
            "success": result.returncode == 0,
            "exit_code": result.returncode,
            "stdout": result.stdout,
            "stderr": result.stderr
        })
    except Exception as e:
        return json.dumps({"success": False, "error": str(e)})

def register(ctx):
    """Registers the python handler tool directly into the active Hermes tool loop context."""
    ctx.register_tool(name="secure_sudo_run", handler=handle_secure_sudo)

