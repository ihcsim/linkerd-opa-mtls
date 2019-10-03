package linkerd.io

import data.pods

injected[p] {
  p := pods[_]
  c := p.containers[_]
  c.name == "linkerd-proxy"
}

not_injected[p] {
  p := pods[_]
  not injected[p]
}

can_automount_service_account_token[p] {
  p := pods[_]
  p.automountServiceAccountToken == true
}

cannot_automount_service_account_token[p] {
  p := pods[_]
  not can_automount_service_account_token[p]
}

has_inject_annotation[p] {
  p := pods[_]
  values := p["metadata"]["annotations"]["linkerd.io/inject"]
  values == "enabled"
}

has_no_inject_annotation[p] {
  p := pods[_]
  not has_inject_annotation[p]
}

# find all injected pods
# >data.linkerd.io.is_injected[_]
#
# find names of all injected pods
# >data.linkerd.io.is_injected[_].name
#
# number of injected pods
# >count(data.linkerd.io.is_injected)
#
# find names of all the pods that can automount service account token
# >data.linkerd.io.can_automount_service_account_token[_].name
#
# find names of all pods that has the auto-inject annotation
# >data.linkerd.io.has_inject_annotation[_].name
