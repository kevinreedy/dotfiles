#
# Cookbook Name:: chef_desktop
# Recipe:: homebrew
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

# Install homebrew
include_recipe 'homebrew'
include_recipe 'homebrew::cask'

# Install packages
# TODO: Make this platform agnostic instead of Mac-only
%w(
  awscli
  docker-compose
  docker-machine
  gpg
  heroku
  nmap
  nvm
  packer
  reattach-to-user-namespace
  s3cmd
  tmux
  watch
  wget
).each do |p|
  package p
end

package 'mtr' do
  options '--no-gtk'
end

# Install cask apps
%w(
  1password
  airfoil
  atom
  dropbox
  firefox
  google-chrome
  iterm2
  sequel-pro
  steam
  sublime-text
).each do |c|
  homebrew_cask c
end

# vagrant
# virtualbox
