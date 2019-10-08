package linkerd.io

test_violation {
  input := {"review": input_review, "parameters": input_parameters}
  results := violation with input as input
  count(results) == 0
}

input_review = {
  "object": {
    "spec": {
      "containers": [
        {
          "name": "linkerd-proxy",
          "env": [
            {"name": "LINKERD2_PROXY_LOG", "value": "warn,linkerd2_proxy=info"}
          ]
        }
      ]
    }
  }
}

input_parameters = {
  "proxy": {
    "name": "linkerd-proxy"
  },
  "env": [
    {"name": "LINKERD2_PROXY_LOG", "value": "warn,linkerd2_proxy=info"}
  ]
}
