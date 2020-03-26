# Terminal colours
export CLICOLOR=1
export LSCOLORS=ExFxCxDxBxegedabagacad

#OktaAWSCLI
#if [[ -f "$HOME/.okta/bash_functions" ]]; then
#    . "$HOME/.okta/bash_functions"
#fi
#if [[ -d "$HOME/.okta/bin" && ":$PATH:" != *":$HOME/.okta/bin:"* ]]; then
#    PATH="$HOME/.okta/bin:$PATH"
#fi

alias python='python3'
alias pip='pip3'

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

set -o vi

alias regions="aws ec2 describe-regions --profile development --query Regions[].RegionName --output text"

alias aws.regions='function _regions(){ for region in $(aws ec2 describe-regions --query Regions[].RegionName --output text --region ap-southeast-2); do echo REGION: $region; aws $@ --region=$region; done; };_regions'


complete -C '/usr/local/bin/aws_completer' aws

alias aws.dev="aws-okta exec okta.dev -- aws"
alias aws.stg="aws-okta exec okta.stg -- aws"
alias aws.prd="aws-okta exec okta.prd -- aws"

export AWS_SDK_LOAD_CONFIG=1

LESSPIPE=`which src-hilite-lesspipe.sh`
export LESSOPEN="| ${LESSPIPE} %s"
export LESS=' -R -X -F '

# Eternal bash history.
# ---------------------
# Undocumented feature which sets the size to "unlimited".
# https://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=
export HISTSIZE=
export HISTTIMEFORMAT="[%F %T] "
# Change the file location because certain bash sessions truncate .bash_history file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login
export HISTFILE=~/.bash_eternal_history
# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"
export PATH=$PATH:/Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/
export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"

eval "$(direnv hook bash)"

# Auto virtualenv.
# ---------------------
function cd() {
  builtin cd "$@"

  if [[ -z "$VIRTUAL_ENV" ]] ; then
    ## If env folder is found then activate the vitualenv
      if [[ -d ./.env ]] ; then
        source ./.env/bin/activate
      fi
  else
    ## check the current folder belong to earlier VIRTUAL_ENV folder
    # if yes then do nothing
    # else deactivate
      parentdir="$(dirname "$VIRTUAL_ENV")"
      if [[ "$PWD"/ != "$parentdir"/* ]] ; then
        deactivate
      fi
  fi
}
