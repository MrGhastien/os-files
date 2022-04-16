#!/bin/bash

#source ~/.git-prompt.sh

		RED="\[\033[0;31m\]"
     YELLOW="\[\033[0;33m\]"
      GREEN="\[\033[0;32m\]"
       BLUE="\[\033[0;34m\]"
       CYAN="\[\033[0;36m\]"
  LIGHT_RED="\[\033[1;31m\]"
LIGHT_GREEN="\[\033[1;32m\]"
 LIGHT_BLUE="\[\033[1;34m\]"
      WHITE="\[\033[1;37m\]"
 LIGHT_GRAY="\[\033[0;37m\]"
 DIM_YELLOW="\[\033[2;33m\]"
   DIM_CYAN="\[\033[2;36m\]"
 COLOR_NONE="\[\e[0m\]"
#DPC : Default Prompt Color
DPC=${DIM_YELLOW}

function parse_git_branch {
	git rev-parse --git-dir &> /dev/null
	git_status="$(git status 2> /dev/null)"
	branch_pattern="^Sur la branche ([^${IFS}]*)"
	remote_pattern="# Your branch is (.*) of"
	diverge_pattern="# Your branch and (.*) have diverged"
	special_token=0
	if [[ ! ${git_status} =~ "la copie de travail est propre" ]]; then
		if [[ ${git_status} =~ "Modifications qui ne seront pas validées" ]]; then
			not_indexed="${RED}*"
			special_token=1
		fi
		if [[ ${git_status} =~ "Modifications qui seront validées" ]]; then
			indexed="${YELLOW}+"
			special_token=1
		fi
		if [[ ${git_status} =~ "Fichiers non suivis" ]]; then
			untracked="${RED}!"
			special_token=1
		fi
	fi
	if [[ ${git_status} =~ ${branch_pattern} ]]; then
		branch=${BASH_REMATCH[1]}
		if (( ${special_token} == 1 )); then
			echo "${LIGHT_BLUE}(${branch} ${not_indexed}${indexed}${untracked}${LIGHT_BLUE})${COLOR_NONE}"
		else
			echo "${LIGHT_BLUE}(${branch})${COLOR_NONE}"
		fi
	fi
}

function set_prompt() {

	prompt="${DPC}[\u@\h ${COLOR_NONE}${DIM_CYAN}\w${COLOR_NONE}${DPC}] ${COLOR_NONE}$(parse_git_branch)${DPC}\$❯${COLOR_NONE}"
	PS1="${prompt} "

}

PROMPT_COMMAND=set_prompt

alias ls="ls --color"

neofetch
