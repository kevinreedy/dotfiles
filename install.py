#!/usr/bin/env python
import os 
import sys
import time

# Special files not to install into previous directory
special_files = {
    '.git',
    '.gitignore',
    'install.py',
    '.install.py.swp',
    'README'
}

# TODO are globals the best idea?
home_dir = os.path.expanduser('~')
script_dir = os.path.realpath(os.path.join(os.getcwd(), os.path.dirname(__file__)))


# directory is the relative path from scriptdir/homedir to process
def process_dir(directory = ""):
    # directory_path is the full path to the dotfiles directory we are processing
    directory_path = script_dir + "/" + directory

    # create the directory in homedir if it doesn't exist
    if not os.path.exists(home_dir + "/" + directory):
        print home_dir + "/" + directory + " does not exist. Creating it."
        os.mkdir(home_dir + "/" + directory)

    # get list of files in directory
    files = os.listdir(directory_path)
    for file_name in files:
        # file_path = full path to the version controlled file
        file_path = directory_path + "/" + file_name
        # TODO fix this hack to remove double /'s
        file_path = file_path.replace("//", "/")

        # make sure file is relative to the dotfiles directory, not current directory
        if directory != "":
            file_name = directory + "/" + file_name

        # do nothing for certain files
        if file_name in special_files:
            print "ignoring file " + file_name
        else:
            # if this is a directory, call this function on it
            if os.path.isdir(file_path):
                process_dir(file_name)
            elif os.path.isfile(file_path):
                process_file(file_name)
            else:
                raise Exception(file_path + " is neither a file nor directory")


# file_name is the relative path from scriptdir/homedir to process
def process_file(file_name):
    # home_file_path is the full path to the destination symlink
    home_file_path = home_dir + "/" + file_name
    script_file_path = script_dir + "/" + file_name

    # do nothing for certain files
    if file_name in special_files:
        print "ignoring file " + file_name
    else:
        if os.path.isfile(script_file_path):
            # if file already exists, make a backup
            if os.path.exists(home_file_path):
                backup_path = home_file_path + ".backup-" + time.strftime("%Y-%m-%d-%H-%M-%S", time.localtime()) 
                print home_file_path + " already exists. renaming it to " + backup_path
                os.rename(home_file_path, backup_path)

            # create a simlink
            print "creating symlink " + home_file_path + " to " + script_file_path
            os.symlink(script_file_path, home_file_path)
        else:
            raise Exception("%s is not a file" %(file_path,))


if __name__ == '__main__':
    process_dir()
