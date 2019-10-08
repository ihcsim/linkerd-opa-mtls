package linkerd.io

import input.review.object.spec.containers
import input.parameters

violation[{"msg":msg, "details":{"proxy": proxy}}] {
  proxy := { proxy |
    some i
    containers[i].name == parameters.proxy.name
    proxy := containers[i]
  }
  count(proxy) == 0
  msg := "Missing proxy sidecar container"

  #some j, k
  #parameters.env[j].name == parameters.env[k].name
  #parameters.env[j].value == proxy.env[k].value

  msg := "Malformed proxy YAML spec"
}
