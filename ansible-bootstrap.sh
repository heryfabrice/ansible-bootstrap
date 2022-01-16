#!/usr/bin/env bash
#########################################################
# An inspiration from Devops automation Cookbook
# Add it to your OS or user PATH environment variable
#########################################################

# HowTo
usage() 
{ 
	echo "Usage: $0 -p PlaybookPath -t PlaybookTitle" 1>&2; exit 1;
	echo "$0 -p /home/johndoe/project1 -t provision_test" 
}

# Gather the users options
while getopts ":p:t:" OPTION; do
	case "${OPTION}" in
	p)
		WORKPATH=${OPTARG};;
	t)
		TITLE=${OPTARG};;
	*)
		usage;;
	esac
done

if [ -z ${WORKPATH} ]; then
	echo "You need to supply a Project Path"
	exit 1
fi
if [ -z ${TITLE} ]; then
	echo "You need to supply a Project Title"
	exit 1
fi

# Now we have the path and title, build the layout
mkdir -p "$WORKPATH/files"
mkdir -p "$WORKPATH/group_vars"
mkdir -p "$WORKPATH/host_vars"
mkdir -p "$WORKPATH/inventories"
mkdir -p "$WORKPATH/roles"

# Use Ansible galaxy init to create a default 'common' role
ansible-galaxy init common --init-path "$WORKPATH/roles/"
touch "$WORKPATH/$TITLE.yml"
