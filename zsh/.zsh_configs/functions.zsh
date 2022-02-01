#!/bin/zsh

function remove_untagged_containers() {
    docker rmi $(docker images | grep '^<none>' | awk '{print $3}')
}

function file_permissions() {
    stat -c "%A %a %N" "$@"
}

function get_named_ip(){
    aws ec2 describe-instances --filters "Name=tag:Name,Values=$1" --query "Reservations[].Instances[].PrivateIpAddress" --output text
}

function get_instances(){
    aws ec2 describe-instances --filters 'Name=tag:Name,Values=*' --query 'Reservations[].Instances[].[Tags[?Key==`Name`] | [0].Value,InstanceId,InstanceType,PrivateIpAddress]' --output table
}

function clear_aws(){
    unset AWS_ACCESS_KEY_ID
    unset AWS_SECRET_ACCESS_KEY
    unset AWS_SESSION_TOKEN
    unset AWS_DEFAULT_REGION
}

function setup_ansible_playbook() {
    mkdir "$@"
    cd "$@"
    mkdir -p inventory/{testing,devtest,rtl,prod}/{group_vars,host_vars}
    touch inventory/{testing,devtest,rtl,prod}/hosts
    mkdir -p roles
    touch roles/requirements.yml
    touch site.yml
    touch README.md
    vagrant init bento/centos-7.4
}

function setup_threat_model(){
    mkdir -p threat-model
    cp $HOME/Sandbox/templates/threat-model/* ./threat-model
}

# FileSearch
function f() { find . -iname "*$1*" ${@:2} }
function r() { grep "$1" ${@:2} -R . }
function s() { ag --hidden --all-types --nogroup --ignore \".git\" -S "$@" }

#mkdir and cd
function mkcd() { mkdir -p "$@" && cd "$_"; }

function threagile() {
    docker run --rm -it -v "$(pwd)":/app/work threagile/threagile "$@"
}

function mini-k() {
    minikube kubectl -- "$@"
}

function prep-adr() {
    npm install -g madr adr-log
    mkdir -p docs/adr
    cp $NODE_PATH/madr/template/* docs/adr
}

function docker-sqlmap(){
    docker run --rm --network=host -it -v /tmp/sqlmap:/root/.sqlmap/ paoloo/sqlmap "$@"
}

function find_pr_for_commit() {
    git log \
        --first-parent \
        --date=relative \
        --pretty=tformat:'%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%an %ad)%Creset' \
        $(perl -ne 'print if ($seen{$_} .= @ARGV) =~ /10$/' <(git rev-list --ancestry-path "$@"..master) <(git rev-list --first-parent "$@"..master) | tail -n 1)

}
