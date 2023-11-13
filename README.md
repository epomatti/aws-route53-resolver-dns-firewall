# AWS Route 53 Resolver DNS Firewall

Exfiltration protection with DNS firewall.

<img src=".assets/diagram.png" width=700 />

Create the infrastructure:

```sh
terraform init
terraform apply -auto-approve
```

After the provisioning, connect to the EC2 instance and test DNS resolution.

Example with override:

<img src=".assets/override.png" />

Example with `NODATA` response:

<img src=".assets/could_not_resolve.png" />
