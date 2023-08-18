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

function deploydelete() {
  kubectl delete deployment -n apps $1
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

function k3s-destroy () {
  for i in 0 1 3; do terraform destroy -target="module.kube-ops[$i].vsphere_virtual_machine.lin    ux[0]" -lock=false; done
}

function dbxp () {
  image_version=$1
  push=$2
  export image_version
  export push
  docker buildx prune
  registry=chkpwd TAG=1.20 ./build.sh
}

function net-utils () {
  local namespace="$1"
  cat "$2" | sed -e "s/\$NAMESPACE/$namespace/g" | k apply -f -
}

function bcrypt () {
  password="$1"
  python -c 'import bcrypt; print(bcrypt.hashpw(b"$password", bcrypt.gensalt(rounds=15)).decode("ascii"))'
}

function hr-reset () {
  hr="$1"
  namespace="$2"
  flux -n $2 suspend $1
  flux -n $2 resume $1
}
