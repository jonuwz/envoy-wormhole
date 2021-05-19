#!/bin/bash

mkdir -p certs
openssl genrsa -out certs/ca.key 4096

openssl req -x509 -new -nodes -key certs/ca.key -sha256 -days 1024 -subj "/CN=wormhole" -out certs/ca.crt

openssl genrsa -out certs/proxy.key 2048

openssl req -new -sha256 \
     -key certs/proxy.key \
     -subj "/C=US/ST=CA/O=tunnels/CN=proxy-splunk-frontend.home.local" \
     -out certs/proxy-splunk-frontend.home.local.csr

openssl req -new -sha256 \
     -key certs/proxy.key \
     -subj "/C=US/ST=CA/O=tunnels/CN=proxy-splunk-backend.home.local" \
     -out certs/proxy-splunk-backend.home.local.csr

openssl x509 -req \
     -in certs/proxy-splunk-frontend.home.local.csr \
     -CA certs/ca.crt \
     -CAkey certs/ca.key \
     -CAcreateserial \
     -extfile <(printf "subjectAltName=DNS:proxy-splunk-frontend.home.local") \
     -out certs/proxy-splunk-frontend.home.local.crt \
     -days 500 \
     -sha256

openssl x509 -req \
     -in certs/proxy-splunk-backend.home.local.csr \
     -CA certs/ca.crt \
     -CAkey certs/ca.key \
     -CAcreateserial \
     -extfile <(printf "subjectAltName=DNS:proxy-splunk-backend.home.local") \
     -out certs/proxy-splunk-backend.home.local.crt \
     -days 500 \
     -sha256


