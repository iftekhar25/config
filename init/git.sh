#!/bin/bash

# Initialize git

usage() {
    cat <<EOF

This command sets up a .gitconfig.

usage: $0 options

OPTIONS:
    -h  Show this message
    -n  Full name, enclosed in inverted commas (")
    -e  Email address
    -u  Username
    -t  API Token from github (if any)

EOF
}

FULLNAME=
EMAILADDRESS=
USERNAME=
APITOKEN=

while getopts "hn:e:u:t:v" OPTION
do
    case $OPTION in
        h)
            usage
            exit 1
            ;;
        n)
            FULLNAME=$OPTARG
            ;;
        e)
            EMAILADDRESS=$OPTARG
            ;;
        u)
            USERNAME=$OPTARG
            ;;
        t)
            APITOKEN=$OPTARG
            ;;
    esac
done

if [[ -z $FULLNAME ]] || [[ -z $EMAILADDRESS ]] || [[ -z $USERNAME ]]
then
    usage
    exit 1
fi

git config --global user.name $FULLNAME
git config --global user.email $EMAILADDRESS
git config --global github.user $USERNAME
if [ -n $APITOKEN ]
then
    git config --global github.token $APITOKEN
fi
git config --global core.editor vim
git config --global color.ui true
