.PHONY: linkerd-%
linkerd-%:
	linkerd $*

linkerd:
	linkerd install  | kubectl apply -f -

gatekeeper:
	kubectl apply -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml

policy:
	kubectl apply -f mtls.yaml

test:
	opa test -v --explain=notes .

clean:
	$(MAKE) linkerd-install | kubectl delete -f -
	kubectl delete constrainttemplates.templates.gatekeeper.sh -l policy.linkerd.io
	kubectl delete crd -l controller-tools.k8s.io=1.0
	kubectl delete -f https://raw.githubusercontent.com/open-policy-agent/gatekeeper/master/deploy/gatekeeper.yaml

