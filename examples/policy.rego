package linkerd.io

injected[pods] {
  pods := data.pods[_]
  c := pods.containers[_]
  c.name == "linkerd-proxy"
}

not_injected[pods] {
  pods := data.pods[_]
  not injected[pods]
}

can_automount_service_account_token[pods] {
  pods := data.pods[_]
  pods.automountServiceAccountToken == true
}

has_inject_annotation[pods] {
  some annotations
  pods := data.pods[_]
  values := pods.metadata.annotations[annotations]
  annotations == "linkerd.io/inject"
  values == "enabled"
}

# find all injected pods
# data.linkerd.io.is_injected[_]

# find names of all injected pods
# data.linkerd.io.is_injected[_].name

# number of injected pods
# count(data.linkerd.io.is_injected)

# find names of all the pods that can automount service account token
# data.linkerd.io.can_automount_service_account_token[_].name

# find names of all pods that has the auto-inject annotation
# data.linkerd.io.has_inject_annotation[_].name

