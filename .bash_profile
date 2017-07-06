alias gnuplot="/Applications/Gnuplot.app/Contents/Resources/bin/gnuplot"
alias octave="/Applications/Octave.app/Contents/Resources/bin/octave"
alias emacs="/Applications/Emacs.app/Contents/MacOS/Emacs"
export GNUTERM=x11
export LANG=ja_JP.UTF-8
export LESSCHARSET=utf-8


##
# Your previous /Users/koheiyasuda/.bash_profile file was backed up as /Users/koheiyasuda/.bash_profile.macports-saved_2014-11-11_at_10:44:27
##

# MacPorts Installer addition on 2014-11-11_at_10:44:27: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.


test -r /sw/bin/init.sh && . /sw/bin/init.sh

# スクリプト読み込み
source $HOME/.git-completion.bash
source $HOME/.git-prompt.sh

# プロンプトに各種情報を表示
GIT_PS1_SHOWDIRTYSTATE=1
GIT_PS1_SHOWUPSTREAM=1
GIT_PS1_SHOWUNTRACKEDFILES=
GIT_PS1_SHOWSTASHSTATE=1

############### ターミナルのコマンド受付状態の表示変更
# \u ユーザ名
# \h ホスト名
# \W カレントディレクトリ
# \w カレントディレクトリのパス
# \n 改行
# \d 日付
# \[ 表示させない文字列の開始
# \] 表示させない文字列の終了
# \$ $
export PS1='\[\033[1;32m\]\u\[\033[00m\]:\[\033[1;34m\]\w\[\033[1;31m\]$(__git_ps1)\[\033[00m\] \$ '
##############
