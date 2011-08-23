#!/bin/bash

# Initialize bash shell environment

# Note: pre-req to this step is to have git setup. To set up git, you
# need macports. To set up macports, you need XCode dev tools. So all
# one needs to remember is to set up git, check out the repo, and run
# this script.

# Install basic tools; assumes sudo access is available, and obviously,
# internet

usage() {
    cat <<EOF

This command installs and sets up your basic command-line shell
environment. It overrides the system versions distributed with Mac OS X,
and then sets up a slightly more fleshed set of bash defaults.

usage: $0 option

OPTION:
    -g  git directory (usually ~/sandbox/config/)

EOF
}

GIT_TREE=

while getopts "g:" OPTION
do
    case $OPTION in
        g)
            GIT_TREE=$OPTARG
            ;;
    esac
done

if [[ -z $GIT_TREE ]]; then
    usage
    exit 1
fi

echo "# INFO upgrading perl"
sudo port install perl
echo "# INFO upgrading vim"
sudo port install vim
echo "# INFO upgrading bash"
sudo port install bash
echo "# INFO installing bash-completion"
sudo port install bash
echo "# INFO installing ack"
sudo port install ack
echo "# INFO installing par"
sudo port install par

# Set up the bash environment just how I like it

bash_dot_files = ( bashrc bash_profile bash_prompt bash_export bash_local );

for file in "${bash_dot_files[@]}"
do
    if [ -f ~/.$file ]; then
        echo "# WARN ~/.$file exists, moving to ~/.$file.old and overriding"
        echo "# INFO symlinking ~/.$file to repository version"
        mv ~/.$file ~/.$file.old
    else
        echo "# INFO symlinking ~/.$file to repository version"
    fi
    ln -s $GIT_TREE/config/dotfiles/$file ~/.$file
done
