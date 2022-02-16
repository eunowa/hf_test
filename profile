##### Enviroment Setting #####
set -o vi
PS1=[`hostname`:'$PWD']#

##### JAVA #####
JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_321.jdk/Contents/Home;export JAVA_HOME
JDK_HOME=${JAVA_HOME};export JDK_HOME
PATH=${JAVA_HOME}:${PATH};export PATH


########## WAS ##########
##### Wildfly #####
JBOSS_HOME=$HOME/wildfly;export JBOSS_HOME
WILDFLY_HOME=$HOME/wildfly;export WILDFLY_HOME

##### Alias #####
alias ll="ls -al"
alias dom='cd $HOME/was/hf_instance'
alias hfbin1='cd $HOME/hf_instance/INS11/bin'
alias hfcfg1='cd $HOME/hf_instance/INS11/configuration'
alias hflog1='cd $HOME/hf_instance/INS11/log'
alias hfbin2='cd $HOME/hf_instance/INS12/bin'
alias hfcfg2='cd $HOME/hf_instance/INS12/configuration'
alias hflog2='cd $HOME/hf_instance/INS12/log'
alias d1='cd $HOME/deployment/www'

########## WEB ##########
##### HTTPD #####
HTTPD_HOME=$HOME/httpd;export HTTPD_HOME

##### Alias #####
alias wbin='cd $HTTPD_HOME/bin'
alias wcfg='cd $HTTPD_HOME/conf'
alias wlog='cd $HTTPD_HOME/logs'
alias d1='cd $HOME/deployment/www'
