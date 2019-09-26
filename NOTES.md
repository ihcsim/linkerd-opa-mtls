## KubeCon Talk
Format:

* Intro to Linkerd
* Intro to OPA Gatekeeper
* mTLS in a zero-trust environment
* Using OPA Gatekeeper to enforce admission policies
* Using Prometheus to alert on unencrypted traffic
* Demo

## Relevant Tools

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
