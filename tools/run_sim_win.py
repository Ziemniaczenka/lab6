#!/usr/bin/env python3

import argparse
import os
import shutil
import subprocess
import sys
from pathlib import Path

# Sprawdzamy, czy jestesmy na Windowsie
IS_WINDOWS = os.name == "nt"

# Pobieranie zmiennych srodowiskowych
try:
    ROOT_DIR = Path(os.environ["ROOT_DIR"])
    SIM_BUILD_DIR = Path(os.environ["SIM_BUILD_DIR"])
except KeyError as e:
    print(f"CRITICAL ERROR: Environment variable {e} is not set.")
    sys.exit(1)

def get_cmd(cmd_name):
    """Zwraca 'cmd.bat' na Windowsie lub 'cmd' na Linuxie"""
    if IS_WINDOWS:
        return f"{cmd_name}.bat"
    return cmd_name

def execute_command(cmd, **kwargs):
    # Konwertujemy wszystkie elementy komendy na stringi
    cmd_str = [str(c) for c in cmd]
    
    print(f"\n=> Executing command:")
    print("    " + " ".join(cmd_str))
    
    subprocess.run(cmd_str, **kwargs)

def run_simulation(args):
    test_name = args.testname
    gui_mode = args.g

    print(f"===== Running simulation for test: {test_name} =====")
    print(f"\n=> Preparing clean build dir: {SIM_BUILD_DIR}")
    
    if SIM_BUILD_DIR.exists():
        shutil.rmtree(SIM_BUILD_DIR, ignore_errors=True)
    SIM_BUILD_DIR.mkdir(parents=True, exist_ok=True)

    prj_file = ROOT_DIR / "sim" / test_name / f"{test_name}.prj"
    
    # --- ZMIANA: .as_posix() zamienia C:\bla\bla na C:/bla/bla ---
    # Jest to wymagane, aby Tcl w Vivado nie zjadł backslashy.
    
    XELAB_OPTS=[
        f"work.{test_name}_test",
        "-snapshot",
        f"{test_name}_test",
        "-prj",
        prj_file.as_posix(),  # <-- TUTAJ ZMIANA
    ]

    cmd_xelab = get_cmd("xelab")
    cmd_xsim  = get_cmd("xsim")

    if gui_mode:
        # GUI Mode
        execute_command([
            cmd_xelab,
            *XELAB_OPTS,
            "-debug",
            "typical"
        ], check=True, cwd=SIM_BUILD_DIR)
        
        tcl_file = ROOT_DIR / "sim" / test_name / "commands.tcl"
        
        execute_command([
            cmd_xsim,
            f"{test_name}_test",
            "-gui",
            "-t",
            tcl_file.as_posix() # <-- TUTAJ ZMIANA (najważniejsza dla Twojego błędu)
        ], check=True, cwd=SIM_BUILD_DIR)
    else:
        # Batch Mode
        execute_command([
            cmd_xelab,
            *XELAB_OPTS,
            "-standalone",
            "-runall"
        ], check=True, cwd=SIM_BUILD_DIR)

def parse_args():
    parser = argparse.ArgumentParser()
    parser.add_argument("-g", action="store_true", help="Run xsim in GUI mode")
    parser.add_argument("testname", help="Name of the test to run")
    return parser.parse_args()

def main():
    args = parse_args()
    try:
        run_simulation(args)
    except subprocess.CalledProcessError as e:
        print(f"\nError during simulation step: {e}")
        sys.exit(1)
    except Exception as e:
        print(f"\nAn unexpected error occurred: {e}")
        sys.exit(1)

if __name__ == "__main__":
    main()