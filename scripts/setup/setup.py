import glob
import json
import os

extensions = {
        "sv"      : ".sv",
        "verilog" : ".v",
        "vhdl"    : ".vhd"
    }

def main(root_dir: str):

    try:
        with open('project_settings.json', 'r') as f_project_settings:
            settings = json.load(f_project_settings)
    except:
        print('JSON file /scripts/setup/project_settings.json either doesnt exist or is malformed')

    for dir in settings['project_dirs']:
        os.makedirs(f'{root_dir}/{dir}', exist_ok=True)
        
    proj = open(f'{root_dir}sim/{settings['name']}_vivado.prj', "w")

    for type, ext in extensions.items():

        # Interfaces must be first
        for file in glob.glob(f'{root_dir}{settings['dir_interfaces']}*{ext}'):
            proj.write(f'{type} work {file}\n')

        # Followed by packages
        for file in glob.glob(f'{root_dir}{settings['dir_packages']}*{ext}'):
            proj.write(f'{type} work {file}\n')

        # Modules and testbenches are last
        for file in glob.glob(f'{root_dir}{settings['dir_modules']}*{ext}'):
            proj.write(f'{type} work {file}\n')

        for file in glob.glob(f'{root_dir}{settings['dir_tests']}*{ext}'):
            proj.write(f'{type} work {file}\n')

        for file in glob.glob(f'{root_dir}{settings['dir_tests']}**/*{ext}'):
            proj.write(f'{type} work {file}\n')

    
    proj.close()

    # Create project.mk using values from project_settings.json
    with open("make_project.mk.tmpl", 'r') as f_make_project_tmpl:
        make_project_tmpl = f_make_project_tmpl.read()

    filled_make_project = make_project_tmpl.format(**settings)

    with open(f'{root_dir}config/make/project.mk', 'w') as f_project_mk:
        f_project_mk.write(filled_make_project)

if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description='Create a Vivado project file')
    parser.add_argument('--root_dir', metavar='str', required=True)

    args = parser.parse_args()

    main(root_dir= args.root_dir)