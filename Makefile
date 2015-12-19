up: discovery-url
	vagrant up

discovery-url:
	@for i in 1 2 3 4 5; do \
		URL=`curl -s -w '\n' https://discovery.etcd.io/new?size=3`; \
		if [ ! -z $$URL ]; then \
			sed -e "s,discovery: #DISCOVERY_URL,discovery: $$URL," contrib/coreos/user-data.example > contrib/coreos/user-data; \
			echo "Wrote $$URL to contrib/coreos/user-data"; \
		    break; \
		fi; \
		if [ $$i -eq 5 ]; then \
			echo "Failed to contact https://discovery.etcd.io after $$i tries"; \
		else \
			sleep 3; \
		fi \
	done

