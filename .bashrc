
## ============================================================================
## alias
## ============================================================================

## 既存sessionがある場合はattachする
alias screen='screen -D -R' 

## detail print
alias ll='ls -la'

## prompt before file destroy operation
alias rm='rm -i'
alias cp='cp -ip'
alias mv='mv -i'


## ============================================================================
## application
## ============================================================================

## default editor is vim
export EDITOR=vim

## default pager is less
export PAGER=less

## set tabstop=4, print percentage, don't erase screen on exit, ANSI color
export LESS='--tabs=4 --LONG-PROMPT -X -R'

## enable grep colors
export GREP_OPTIONS='--color=auto'


## ============================================================================
## completion
## ============================================================================

if [ -f /usr/local/etc/bash_completion ]; then
    . /usr/local/etc/bash_completion
fi

if [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
fi


## ============================================================================
## history
## ============================================================================

## メモリに保存するhistory数
HISTSIZE=100000

## ディスクに保存するhistory数
HISTFILESIZE=100000

## historyにタイムスタンプを追加
## 2017-12-01 00:00:00
HISTTIMEFORMAT="[%F %T] "

## historyに保存しないコマンド
HISTIGNORE="history"

## ignoredup 直前に実行したのと同じコマンドはhistoryに追加しない
## ignorespace 先頭に空白を入れた場合はhistoryに追加しない
## ignoreboth ignoredup+ignorespace
HISTCONTROL=ignoreboth

## historyの追記を有効にする
## 保存タイミングは終了時
shopt -s histappend

## コマンド実行毎にhistoryファイルへの追記と差分読み込みを実施
PROMPT_COMMAND_HISTORY="history -a; history -n"


## ============================================================================
## prompt 
## ============================================================================

## PROMPT_COMMANDの実行用関数
## PROMPT_COMMAND_で始まる名前のものをすべて実行する
prompt_command_dispatch() {
    local func
    for func in ${!PROMPT_COMMAND_*}; do
        eval "${!func}"
    done
    unset func
}
PROMPT_COMMAND="prompt_command_dispatch"

## TERMがscreenを含む場合
## screenのcaptionに現在のフォルダパスを設定
case $TERM in
    screen*)
        PROMPT_COMMAND_SCREEN='printf "\033k\033\134\033k%s:%s\033\\" "${HOSTNAME%%.*}" `basename "${PWD/#$HOME/~}"`'
        ;;
esac

## プロンプトの表示内容を設定
## SSHでの接続中かどうかで色を変える
if [ -z "$SSH_CONNECTION" ]; then
    PS1="[\[\033[32m\]\h\[\033[37m\]]$ "  # local session (blue)
else
    PS1="[\[\033[31m\]\h\[\033[37m\]]$ "  # remote session (red)
fi

