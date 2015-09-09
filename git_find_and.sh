# git_find_and: Find commit interactively and do somethinng
#
# Copyright 2015 Hiroyuki Yamada
#
# This is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# This is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# You should have received a copy of the GNU General Public License
# along with this.  If not, see <http://www.gnu.org/licenses/>.
#
########################################################################

#
# 0. Dependency
#  git  : http://git-scm.com/
#  peco : https://peco.github.io/
#
# 1. Install
#  Write in ~/.bashrc (or your shell config file)
#
#  if [ -f /path/to/git_find_and.sh ]; then
#    source /path/to/git_find_and.sh
#  fi
#
# 2. Usage
#   git_find_and [cmd [query]]
#
#   cmd  : git command. Default value is "show"
#   query: Initial query passed to peco
#

#
# Now it become more important to write meaningful first line in your commit message :-)
#

function git_find_and()
{
    case $# in
	0 )
	    local id=$(git log --oneline --decorate --branches --tags | peco | cut -f 1 -d " " -)
	    if [ -n "${id}" ]; then
		git show ${id}
	    fi
	    ;;
	1 )
	    local id=$(git log --oneline --decorate --branches --tags | peco | cut -f 1 -d " " -)
	    if [ -n "${id}" ]; then
		git "$1" ${id}
	    fi
	    ;;
	2 )
	    local id=$(git log --oneline --decorate --branches --tags | peco --query "$2" | cut -f 1 -d " " -)
	    if [ -n "${id}" ]; then
		git "$1" ${id}
	    fi
	    ;;
	* )
	    echo 'Too many arguments.'
	    echo ''
	    echo 'git_find_and [cmd [query]]'
	    echo ''
	    echo '  cmd  :  git command. Default value is "show"'
	    echo '  query:  initial query passed to peco'
	    ;;
    esac
}
