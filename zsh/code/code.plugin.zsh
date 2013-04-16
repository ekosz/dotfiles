c() { cd ~/Code/$1; }
_c() { _files -W ~/Code -/; }
compdef _c c

gitlogshow() { git log --oneline | grep $1 | cut -d ' ' -f 1 | xargs git show; }
alias gls='gitlogshow'

alias mysqlstart='sudo /opt/local/share/mysql5/mysql/mysql.server start'
alias mysqlstop='/opt/local/bin/mysqladmin5 -u root -p shutdown'
alias fcconsole='ssh fc@founderscard.com "cd app/current && ./script/console production"'

alias ipad='open /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/Applications/iPhone\ Simulator.app'
