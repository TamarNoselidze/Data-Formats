jq '[.root.person[] | select(.athlete and (.birthDate | strptime("%Y-%m-%dT%H:%M:%SZ") > "2002-01-01T00:00:00Z"))] | length'