#!/usr/bin/env python
import os 

# Special files not to install into previous directory
# TODO Make this work entire whole path so we can exclude .ssh/authorized_keys but not .something/authorized_keys 
special_files = {
    '.git',
    '.gitignore',
    'install.py',
    'README'
}

def process_dir(dir_path):
    # TODO Create new folder in parent if it doesn't exist (../.ssh/ for example) 
    files = os.listdir(dir_path)

    for file_name in files:
        full_path = dir_path + "/" + file_name
        if file_name not in special_files:
            if os.path.isdir(full_path):
                print "found a directory: %s" % (full_path,)
                process_dir(full_path)
            elif os.path.isfile(full_path):
                process_file(full_path)
            else:
                raise Exception("%s is neither a file nor directory" %(full_path,))

def process_file(file_name):
    if file_name not in special_files:
        if os.path.isfile(file_name):
            print "linking file: %s" %(file_name,)
            # TODO actually link the file in .. (be sure to make sure .ssh/file works properly)
        else:
            raise Exception("%s is not a file" %(file_name,))


if __name__ == '__main__':
    process_dir('.')
