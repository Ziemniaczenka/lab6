#!/usr/bin/env python3

import os
import shutil
import subprocess
import sys
from pathlib import Path


# The script is in <root>/tools, so the root is two levels up.
ROOT_DIR = Path(__file__).parent.parent.resolve()

# Define paths relative to the project root.
# This assumes your Vivado project and scripts are in an `fpga` directory.
FPGA_DIR = ROOT_DIR / "fpga"
FPGA_BUILD_DIR = ROOT_DIR / "build" / "fpga"
RESULTS_DIR = ROOT_DIR / "results"

IS_WINDOWS = os.name == "nt"

WARNING_SUMMARY_FILE = RESULTS_DIR / "warning_summary.log"

def execute_command(cmd, **kwargs):
    print(f"\n=> Executing command:")
    print("    " + " ".join(cmd))
    subprocess.run(cmd, **kwargs)

def generate_bitstream():
    print(f"===== Generating bitstream =====")

    print(f"\n=> Preparing clean build dir: {FPGA_BUILD_DIR}")
    shutil.rmtree(FPGA_BUILD_DIR, ignore_errors=True)
    FPGA_BUILD_DIR.mkdir(parents=True, exist_ok=True)

    vivado_cmd = "vivado.bat" if IS_WINDOWS else "vivado"

    execute_command([
        vivado_cmd,
        "-mode",
        "tcl",
        "-source",
        "scripts/generate_bitstream.tcl",
    ], check=True, cwd=FPGA_DIR)

def copy_bitstream_to_results():
    RESULTS_DIR.mkdir(parents=True, exist_ok=True)
    for bitstream_file in FPGA_BUILD_DIR.rglob("*.bit"):
        shutil.copy2(bitstream_file, RESULTS_DIR / bitstream_file.name)

def main():
    try:
        generate_bitstream()
        copy_bitstream_to_results()
    except Exception as e:
        print(f"An error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()
