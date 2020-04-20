test:
	prove6 --lib t/

start-riak-container:
	docker run --name=riak-fhir -d -p 8087:8087 -p 8098:8098 basho/riak-kv

start-scylla-container:
	docker run --name=scylla-fhir -d --hostname some-scylla -p 9042:9042 scylladb/scylla
