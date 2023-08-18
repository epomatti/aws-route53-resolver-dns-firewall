resource "aws_route53_resolver_firewall_config" "main" {
  resource_id = var.vpc_id

  # Favors security over availability
  firewall_fail_open = "DISABLED"
}

resource "aws_route53_resolver_firewall_domain_list" "custom_block" {
  name = "MyCustomDomainList"
  domains = [
    "google.com",
    "pomatti.io"
  ]
}

resource "aws_route53_resolver_firewall_rule_group" "my_group" {
  name = "MyGroup"
}

resource "aws_route53_resolver_firewall_rule" "block_custom" {
  name   = "BlockCustom"
  action = "BLOCK"
  # block_override_dns_type = "CNAME"
  # block_override_domain   = "example.com"
  # block_override_ttl      = 1
  # block_response          = "OVERRIDE"
  block_response          = "NODATA"
  firewall_domain_list_id = aws_route53_resolver_firewall_domain_list.custom_block.id
  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.my_group.id
  priority                = 100
}

resource "aws_route53_resolver_firewall_rule_group_association" "my_group" {
  name                   = "mygroup-association"
  firewall_rule_group_id = aws_route53_resolver_firewall_rule_group.my_group.id
  priority               = 200
  vpc_id                 = var.vpc_id
}

### Managed Rules (us-east-2) ###

resource "aws_route53_resolver_firewall_rule" "AWSManagedDomainsAggregateThreatList" {
  name                    = "AWSManagedDomainsAggregateThreatList"
  action                  = "BLOCK"
  block_response          = "NODATA"
  firewall_domain_list_id = "rslvr-fdl-bbc798062d594728"
  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.my_group.id
  priority                = 101
}

resource "aws_route53_resolver_firewall_rule" "AWSManagedDomainsAmazonGuardDutyThreatList" {
  name                    = "AWSManagedDomainsAmazonGuardDutyThreatList"
  action                  = "BLOCK"
  block_response          = "NODATA"
  firewall_domain_list_id = "rslvr-fdl-996a2e1ce1314abb"
  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.my_group.id
  priority                = 102
}

resource "aws_route53_resolver_firewall_rule" "AWSManagedDomainsBotnetCommandandControl" {
  name                    = "AWSManagedDomainsBotnetCommandandControl"
  action                  = "BLOCK"
  block_response          = "NODATA"
  firewall_domain_list_id = "rslvr-fdl-3c30dcb4c50b4401"
  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.my_group.id
  priority                = 103
}

resource "aws_route53_resolver_firewall_rule" "AWSManagedDomainsMalwareDomainList" {
  name                    = "AWSManagedDomainsMalwareDomainList"
  action                  = "BLOCK"
  block_response          = "NODATA"
  firewall_domain_list_id = "rslvr-fdl-19f9b4c730a14748"
  firewall_rule_group_id  = aws_route53_resolver_firewall_rule_group.my_group.id
  priority                = 104
}
