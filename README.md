# Linkerd OPA mTLS
This project is an experiment to ensure the [Linkerd](https://linkerd.io) mTLS by using the [OPA Gatekeeper](https://github.com/open-policy-agent/gatekeeper) to enforce certain workload admission policies.

## Getting Started
To install Linkerd and OPA Gatekeeper,
```
make opa
make linkerd-install | kubectl apply -f -
```

Install the OPA constraint template and constraints:
```
kubectl apply -f opa-linkerd-mtls.yaml
```

To remove both Linkerd and OPA Gatekeeper,
```
make clean
```

## Development
To test the mTLS rules, run:
```
make test
```
