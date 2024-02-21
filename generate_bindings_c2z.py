import os
import sys
import subprocess


class Header:
    def __init__(self, filepath, includes=None):
        self.filepath = filepath
        self.includes = includes or []


headers = [
    # os.path.join("zig-recastnavigation", "Recast", "Include", "Recast.h"),
    # os.path.join("zig-recastnavigation", "Recast", "Include", "RecastAlloc.h"),
    # os.path.join("zig-recastnavigation", "Recast", "Include", "RecastAssert.h"),
    Header(
        os.path.join("Recast", "Include", "Recast.h"),
    ),
    Header(
        os.path.join("Detour", "Include", "DetourCommon.h"),
    ),
    Header(
        os.path.join("DetourTileCache", "Include", "DetourTileCache.h"),
        [
            os.path.join("..", "..", "Detour", "Include"),
        ],
    ),
]


def get_headers():
    return headers


def generate(c2z_exe_path, project_root_path, header):
    print("/////////////////////////")
    print("Generating", header.filepath)
    print("Includes:", header.includes)
    print("Root path:", project_root_path)
    print("c2z path:", c2z_exe_path)

    header_filename = os.path.join(project_root_path, header.filepath)
    print("Full path:", header_filename)
    header_folderpath = os.path.dirname(header_filename)
    os.chdir(header_folderpath)

    print("In folder:", header_folderpath)
    print("-------------------------")

    run_params = []
    run_params.append(c2z_exe_path)
    for include_path in header.includes:
        run_params.append("-I" + include_path)

    run_params.append(header_filename)

    subprocess.run(
        run_params,
        cwd=".",
        capture_output=False,
        text=True,
    )

    print("\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\")

    # Back down to external...
    os.chdir(project_root_path)


def build_c2z():
    # assume we're at /external
    os.chdir("c2z")

    print("Building c2z...")
    subprocess.run(
        [
            "zig",
            "build",
            # "-Dtarget=native-native-msvc",
            # "--summary",
            # "failures",
        ],
        cwd=".",
        capture_output=False,
        text=True,
    )

    # Back down to external...
    os.chdir("..")


if __name__ == "__main__":
    # Default to Tides of Revival's setup
    c2z_exe_path = os.path.join(os.getcwd(), "..", "c2z", "zig-out", "bin", "c2z")
    if len(sys.argv) > 1:
        c2z_exe_path = sys.argv[1]

    project_root_path = os.getcwd()
    for header in get_headers():
        generate(c2z_exe_path, project_root_path, header)

    print("")
    print("Done, press enter!")
    a = input()
