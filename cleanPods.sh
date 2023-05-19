#!/bin/bash
# The script checks all namespaces and deletes pods in statuses like 'NodeAffinity','Terminated'.

namespaces=$(kubectl get ns --no-headers | awk '{print $1}') 

for ns in ${namespaces[@]}; do

  delpods=$(kubectl get pods -n $ns | grep -i 'Terminated\|NodeAffinity' |  awk '{print $1 }')   

  for pod in ${delpods[@]}; do

    kubectl delete pod $pod --force=true --wait=false \
      --grace-period=0 -n $ns
      
  done

done