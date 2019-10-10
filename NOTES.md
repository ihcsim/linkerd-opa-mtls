## KubeCon Talk
Format:

* Intro to Linkerd
* Intro to OPA Gatekeeper
* Why mTLS? zero-trust, how `identity` works
* Why use Gatekeeper to enforce admission policies?
* Demo
  * Deploy uninjected emojivoto
  * Deploy Linkerd and Gatekeeper
    * Gatekeeper should report previously uninjected workloads
  * Deploy uninjected emojivoto
    * Gatekeeper should reject admission requests
  * Inject emojivoto - now it works
  * Verify mTLS using `linkerd edge` and `ksniff`
  * Verify mTLS as workloads become non-compliant
    * Scale proxy injector to zero, Gatekeeper should still disallow uninjected workloads from entering the mesh
    * Linkerd said it's mTLS'ed, but is it?
* What's Next?
  * We showed you the basic; here are more stuff you can do on your own
  * Runtime policy enforcement

## Questions

1. Any documentation on how Gatekeeper's rego is different?
1. Why is there a limitation on the name of the constraint template? i.e. must match CRD kind

## About Linkerd mTLS Constraints
Use multiple rules in the `violation` rule. By default, when multiple
expressions are joined together in a query, you are expressing logical AND. To
express logical OR, you define multiple rules with the same name.
See [here](https://www.openpolicyagent.org/docs/latest/#logical-or).

## Relevant Tools
Here are some tools that might be relevant for the demo:

* [ksniff](https://github.com/eldadru/ksniff)

## About opa-istio
High-level information:

* Launches `opa` as a server
* Uses a mutating admission webhook to inject a sidecar to enforce OPA policy
* Policy is mounted as config map to the sidecar
* Implements the _Envoy External Authorization API_
    * Exposes the `envoy.service.auth.v2.Authoriation/Check` endpoint

* Not appropriate for determining encrypted traffic:
  * Sniffing the traffic requires the OPA sidecar to MITM the traffic.
  * Latency due to the decrypting and re-encrypting of the traffic.
