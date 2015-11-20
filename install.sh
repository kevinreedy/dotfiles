#!/bin/bash
# You probably shouldn't use this yet
curl -L https://www.chef.io/chef/install.sh | sudo bash
berks vendor cookbooks
chef-client -z -o chef_desktop
