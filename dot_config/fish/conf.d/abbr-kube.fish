#!/usr/bin/env fish

if type -q kubectl
    abbr k kubectl
end

# All namespaces
abbr kca 'kubectl $argv --all-namespaces'

# Events
abbr kge 'kubectl get events'
abbr kgea 'kubectl get events --all-namespaces'
abbr kgew 'kubectl get events --watch'

# Apply
abbr kaf 'kubectl apply -f'

# Exec
abbr keti 'kubectl exec -ti'

# Config management
abbr kcuc 'kubectl config use-context'
abbr kcsc 'kubectl config set-context'
abbr kcdc 'kubectl config delete-context'
abbr kccc 'kubectl config current-context'
abbr kcgc 'kubectl config get-contexts'
abbr kcn 'kubectl config set-context --current --namespace'

# Delete
abbr kdel 'kubectl delete'
abbr kdelf 'kubectl delete -f'

# Pods
abbr kgp 'kubectl get pods'
abbr kgpa 'kubectl get pods --all-namespaces'
abbr kgpw 'kubectl get pods --watch'
abbr kgpwide 'kubectl get pods -o wide'
abbr kep 'kubectl edit pods'
abbr kdp 'kubectl describe pods'
abbr kdelp 'kubectl delete pods'
abbr kgpall 'kubectl get pods --all-namespaces -o wide'
abbr kgpl 'kubectl get pods -l'
abbr kgpn 'kubectl get pods -n'

# Metrics
abbr ktp 'kubectl top pods'
abbr ktpa 'kubectl top pods --all-namespaces'
abbr ktpw 'kubectl top pods --watch'
abbr ktpp 'kubectl top pods -o wide'

# Services
abbr kgs 'kubectl get svc'
abbr kgsa 'kubectl get svc --all-namespaces'
abbr kgsw 'kubectl get svc --watch'
abbr kgswide 'kubectl get svc -o wide'
abbr kes 'kubectl edit svc'
abbr kds 'kubectl describe svc'
abbr kdels 'kubectl delete svc'

# Ingress
abbr kgi 'kubectl get ingress'
abbr kgia 'kubectl get ingress --all-namespaces'
abbr kei 'kubectl edit ingress'
abbr kdi 'kubectl describe ingress'
abbr kdeli 'kubectl delete ingress'

# Namespaces
abbr kgns 'kubectl get namespaces'
abbr kens 'kubectl edit namespace'
abbr kdns 'kubectl describe namespace'
abbr kdelns 'kubectl delete namespace'

# ConfigMaps
abbr kgcm 'kubectl get configmaps'
abbr kgcma 'kubectl get configmaps --all-namespaces'
abbr kecm 'kubectl edit configmap'
abbr kdcm 'kubectl describe configmap'
abbr kdelcm 'kubectl delete configmap'

# Secrets
abbr kgsec 'kubectl get secret'
abbr kgseca 'kubectl get secret --all-namespaces'
abbr kdsec 'kubectl describe secret'
abbr kdelsec 'kubectl delete secret'

# Deployments
abbr kgd 'kubectl get deployment'
abbr kgda 'kubectl get deployment --all-namespaces'
abbr kgdw 'kubectl get deployment --watch'
abbr kgdwide 'kubectl get deployment -o wide'
abbr ked 'kubectl edit deployment'
abbr kdd 'kubectl describe deployment'
abbr kdeld 'kubectl delete deployment'
abbr ksd 'kubectl scale deployment'
abbr krsd 'kubectl rollout status deployment'

# Rollouts
abbr kgrs 'kubectl get rs'
abbr krh 'kubectl rollout history'
abbr kru 'kubectl rollout undo'

# StatefulSets
abbr kgss 'kubectl get statefulset'
abbr kgssa 'kubectl get statefulset --all-namespaces'
abbr kgssw 'kubectl get statefulset --watch'
abbr kgsswide 'kubectl get statefulset -o wide'
abbr kess 'kubectl edit statefulset'
abbr kdss 'kubectl describe statefulset'
abbr kdelss 'kubectl delete statefulset'
abbr ksss 'kubectl scale statefulset'
abbr krsss 'kubectl rollout status statefulset'

# Port forwarding
abbr kpf 'kubectl port-forward'

# All resources
abbr kga 'kubectl get all'
abbr kgaa 'kubectl get all --all-namespaces'

# Logs
abbr kl 'kubectl logs'
abbr kl1h 'kubectl logs --since 1h'
abbr kl1m 'kubectl logs --since 1m'
abbr kl1s 'kubectl logs --since 1s'
abbr klf 'kubectl logs -f'
abbr klf1h 'kubectl logs --since 1h -f'
abbr klf1m 'kubectl logs --since 1m -f'
abbr klf1s 'kubectl logs --since 1s -f'

# File copy
abbr kcp 'kubectl cp'

# Nodes
abbr kgno 'kubectl get nodes'
abbr keno 'kubectl edit node'
abbr kdno 'kubectl describe node'
abbr kdelno 'kubectl delete node'

# PVCs
abbr kgpvc 'kubectl get pvc'
abbr kgpvca 'kubectl get pvc --all-namespaces'
abbr kgpvcw 'kubectl get pvc --watch'
abbr kepvc 'kubectl edit pvc'
abbr kdpvc 'kubectl describe pvc'
abbr kdelpvc 'kubectl delete pvc'

# Service accounts
abbr kdsa 'kubectl describe sa'
abbr kdelsa 'kubectl delete sa'

# DaemonSets
abbr kgds 'kubectl get daemonset'
abbr kgdsw 'kubectl get daemonset --watch'
abbr keds 'kubectl edit daemonset'
abbr kdds 'kubectl describe daemonset'
abbr kdelds 'kubectl delete daemonset'

# Jobs
abbr kgj 'kubectl get job'
abbr kcj 'kubectl create job'
abbr kej 'kubectl edit job'
abbr kdj 'kubectl describe job'
abbr kdelj 'kubectl delete job'

# CronJobs
abbr kgcj 'kubectl get cronjob'
abbr kecj 'kubectl edit cronjob'
abbr kdcj 'kubectl describe cronjob'
abbr kdelcj 'kubectl delete cronjob'
