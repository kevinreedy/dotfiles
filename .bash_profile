#EDITOR="atom -w -n"
EDITOR=/usr/bin/vim
export EDITOR
PATH=$PATH:/usr/local/sbin
export PATH
PATH=$PATH:~/bin
export PATH

if [ -f ~/.bashrc ]; then
   source ~/.bashrc
fi

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
[[ -s /Users/kreedy/.nvm/nvm.sh ]] && . /Users/kreedy/.nvm/nvm.sh # This loads NVM

function rmb {
  current_branch=$(git branch --no-color 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
  if [ "$current_branch" != "master" ]; then
    echo "WARNING: You are on branch $current_branch, NOT master."
  fi
    echo "Fetching merged branches..."
  git remote prune origin
  remote_branches=$(git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$")
  local_branches=$(git branch --merged | grep -v 'master$' | grep -v "$current_branch$")
  if [ -z "$remote_branches" ] && [ -z "$local_branches" ]; then
    echo "No existing branches have been merged into $current_branch."
  else
    echo "This will remove the following branches:"
    if [ -n "$remote_branches" ]; then
      echo "$remote_branches"
    fi
    if [ -n "$local_branches" ]; then
      echo "$local_branches"
    fi
    read -p "Continue? (y/n): " -n 1 choice
    echo
    if [ "$choice" == "y" ] || [ "$choice" == "Y" ]; then
      # Remove remote branches
      git push origin `git branch -r --merged | grep -v '/master$' | grep -v "/$current_branch$" | sed 's/origin\//:/g' | tr -d '\n'`
      # Remove local branches
      git branch -d `git branch --merged | grep -v 'master$' | grep -v "$current_branch$" | sed 's/origin\///g' | tr -d '\n'`
    else
      echo "No branches removed."
    fi
  fi
}

function newb {
  echo "Creating branch $1 off of upstream/master"
  git checkout master
  git pull upstream master
  git checkout -b $1
}

function jssh {
  stack=${1:-api}
  env=${2:-production}
  hosts=(`aws --region "us-east-1" ec2 describe-instances --filters "Name=group-name,Values=$stack-$env" | jq ".Reservations[].Instances[].PublicIpAddress" | grep -v null | cut -d\" -f 2`)
  if [ "${#hosts[@]}" -eq 0 ]; then
    echo "found no hosts in $stack-$env"
  else
    randomhost=${hosts[$RANDOM % ${#hosts[@]} ]}
    echo "connecting to $randomhost in $stack-$env"
    ssh $randomhost
  fi
}
jrun () {
        stack=${1:-api} 
        env=${2:-production} 
        cmd=${3:-w} 
        hosts=(`aws --region "us-east-1" ec2 describe-instances --filters "Name=instance.group-name,Values=jockey-$stack-$env" | jq ".Reservations[].Instances[].PrivateIpAddress" | cut -d\" -f 2`) 
        if [ "${#hosts[@]}" -eq 0 ]
        then
                echo "found no hosts in $stack-$env"
        else
                for host in "${hosts[@]}"
                do
                        echo "*** $host ***"
                        ssh -n $host $cmd
                        echo
                done
        fi
}
#function jrun {
#  stack=${1:-api}
#  env=${2:-production}
#  cmd=${3:-w}
#  hosts=(`aws --region "us-east-1" ec2 describe-instances --filters "Name=group-name,Values=$stack-$env" | jq ".Reservations[].Instances[].PublicIpAddress" | grep -v null | cut -d\" -f 2`)
#  if [ "${#hosts[@]}" -eq 0 ]; then
#    echo "found no hosts in $stack-$env"
#  else
#    for host in "${hosts[@]}"
#    do
#      echo "*** $host ***"
#      ssh -n $host $cmd
#      echo
#    done
#  fi
#}
