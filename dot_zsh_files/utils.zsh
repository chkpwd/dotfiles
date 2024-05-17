#!/usr/bin/env zsh

# transfer.sh alias
transfer(){ if [ $# -eq 0 ];then echo "No arguments specified.\nUsage:\n transfer <file|directory>\n ... | transfer <file_name>">&2;return 1;fi;if tty -s;then file="$1";file_name=$(basename "$file");if [ ! -e "$file" ];then echo "$file: No such file or directory">&2;return 1;fi;if [ -d "$file" ];then file_name="$file_name.zip" ,;(cd "$file"&&zip -r -q - .)|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null,;else cat "$file"|curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;else file_name=$1;curl --progress-bar --upload-file "-" "https://transfer.sh/$file_name"|tee /dev/null;fi;}

# Enter a running Docker container
function denter() {
    if [[ ! "$1" ]] ; then
        echo "You must supply a container ID or name."
        return 0
    fi

    docker exec -it $1 bash
    return 0
}

# Password generation
pwgen() {
    LC_ALL=C tr -dc 'A-Za-z0-9' </dev/urandom | head -c 32 ; echo;
}

function runjob() {
  temp_job_name=$1-$(date +%s)
  kubectl create job --from=cronjobs/$1 $temp_job_name -n $2 &&
    echo Delete Job: kubectl delete job $temp_job_name
}

function killport() {
  echo $(lsof -ti:$1)
  lsof -ti:$1 | xargs kill
  echo "killed port ${1}"
}

function prev() {
  PREV=$(fc -lrn | head -n 1)
  sh -c "pet new `printf %q "$PREV"`"
}

function cypher {
    filename=$(basename -- "$1")
    extension="${filename##*.}"
    filename="${filename%.*}"
    sops --encrypt --age $(cat ~/.config/sops/age/keys.txt |grep -oP "public key: \K(.*)") $2 $3 $1 > "$filename.sops.$extension"
}

function net-utils () {
  local namespace="$1"
  cat "$2" | sed -e "s/\$NAMESPACE/$namespace/g" | kubectl apply -f -
}

function bcrypt () {
  password="$1"
  python -c 'import bcrypt; print(bcrypt.hashpw(b"$password", bcrypt.gensalt(rounds=15)).decode("ascii"))'
}

function hr-reset () {
  flux -n $1 suspend hr $2
  flux -n $1 resume hr $2
}

function pod-logs () {
  local namespace=""
  if [ ! -z "$2" ]; then
    namespace="-n $2"
  fi

  for i in $(kubectl get pods $namespace $1 -o json | jq -r '.spec.containers[].name'); do
    kubectl logs $namespace $1 -c $i
  done
}

