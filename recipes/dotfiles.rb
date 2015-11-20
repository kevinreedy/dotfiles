#
# Cookbook Name:: chef_desktop
# Recipe:: dotfiles
#
# Copyright 2015 Kevin Reedy
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# For now, this recipe will just replace install.py and leave file resources out of the picture

IGNORE_LIST = %w(
  .
  ..
  .DS_Store
)

def process_dir(path)
  Dir.foreach(File.expand_path(path)) do |file|
    next if IGNORE_LIST.include? file

    if File.directory?(File.expand_path(file, path))
      process_dir(File.expand_path(file, path))
    else
      # TODO: make symlink, but for now log
      Chef::Log.warn File.expand_path(file, path)
    end
  end
end

# TODO: pass in the user/dir somewhere since chef may run as room
process_dir('~/Projects/kevinreedy/dotfiles/files/default')
