#!/usr/bin/env python
import os 
import sys

# Special files not to install into previous directory
# TODO Make this work entire whole path so we can exclude .ssh/authorized_keys but not .something/authorized_keys 
special_files = {
    '.git',
    '.gitignore',
    'install.py',
    'README'
}

def process_dir(dir_path):
    # Create the directory if it doesn't exist
    if not os.path.exists("." + dir_path):
        print "." + dir_path + " does not exist. Creating it."
        os.mkdir("." + dir_path)


    files = os.listdir(dir_path)
    for file_name in files:
        full_path = dir_path + "/" + file_name

        # do nothing for certain files
        if file_name not in special_files:
            # if this is a directory, call this function on it
            if os.path.isdir(full_path):
                print "found directory: %s" % (full_path,)
                process_dir(full_path)
            elif os.path.isfile(full_path):
                process_file(full_path)
            else:
                raise Exception("%s is neither a file nor directory" %(full_path,))

def process_file(file_name):
    if file_name not in special_files:
        if os.path.isfile(file_name):
            # if file already exists, make a backup
            if os.path.exists("." + file_name):
                print "." + file_name + " already exists. renaming it to " + file_name + ".backup"
                os.rename("." + file_name, "." + file_name + ".backup")

            # create a simlink
            #TODO This is resulting in dotfiles/./.gitconfig, which doesn't work for subdirs and is ugly
            print "creating symlink for " + file_name + " to ." + file_name 
            os.symlink("dotfiles/" + file_name, "." + file_name)
        else:
            raise Exception("%s is not a file" %(file_name,))


if __name__ == '__main__':
    process_dir('.')
