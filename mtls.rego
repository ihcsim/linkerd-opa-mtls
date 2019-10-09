package linkerd.io

import input.review.object.spec.containers
import input.parameters

violation[{"msg":msg, "details":{}}] {
  some i
  proxy := { proxy |
    containers[i].name == parameters.proxy.name
    proxy := containers[i]
  }
  count(proxy) == 0
  msg := sprintf("Missing proxy sidecar container: %v", [parameters.proxy.name])
}

violation[{"msg":msg, "details":{}}] {
  some j, k
  env := { variable: value |
    some i
    containers[i].name == parameters.proxy.name
    proxy := containers[i]

    parameters.env[j].name == proxy.env[k].name
    parameters.env[j].value == proxy.env[k].value
    variable := proxy.env[k].name
    value := proxy.env[k].value
  }
  count(env) == 0
  msg := sprintf("Missing required environment variable: %v=%v", [parameters.env[j].name, parameters.env[j].value])
}
