# Allow managing secrets under the 'secrets/' path
# (Adjust 'secrets' if your KV mount path is different, but 'secrets' is the default used in the og-util code)
path "secrets/*" {
  capabilities = ["read", "list", "create", "update", "delete"]
}