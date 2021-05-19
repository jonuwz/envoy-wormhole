# envoy-wormhole
example setup to tunnel traffic

exposed on localhost:10000, will connect to whatever your backends are in envoy-backend

TCP -> envoy -> mTLS -> envoy -> backend

TODO:
LB, healthchecks etc etc
