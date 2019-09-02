# Linkerd OPA mTLS
This project is an experimentation to enforce the [Linkerd](https://linkerd.io) mTLS admission policy using the [OPA Gatekeeper](https://github.com/open-policy-agent/gatekeeper).

## Getting Started
Install Linkerd per installation instructions found on the Linkerd [docs](https://linkerd.io/2/getting-started/).

Install OPA Gatekeeper per installation instructions [here](kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml).

Install the OPA constraint template and constraints:
```
kubectl apply -f opa-linkerd-mtls.yaml
```
