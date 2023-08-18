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

# TODO: Add managed rule

resource "aws_route53_resolver_firewall_rule_group_association" "my_group" {
  name                   = "mygroup-association"
  firewall_rule_group_id = aws_route53_resolver_firewall_rule_group.my_group.id
  priority               = 200
  vpc_id                 = var.vpc_id
}
