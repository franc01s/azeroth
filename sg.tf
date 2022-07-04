
#-------------------------------------------------------------------------------
# API SG
#-------------------------------------------------------------------------------
resource "exoscale_security_group" "company-api-sg" {
  name = format("%s-api-sg", var.company)
  description = format("%s API Security Group", var.company)
}

resource "exoscale_security_group_rule" "company-api-sg-rule-rdp" {
  count = length(var.cidr)
  type = "INGRESS"
  security_group_id = exoscale_security_group.company-api-sg.id
  protocol = "TCP"
  cidr = var.cidr[count.index]
  start_port = 22
  end_port = 22
}

resource "exoscale_security_group_rule" "company-api-sg-rule-3724" {
  type = "INGRESS"
  security_group_id = exoscale_security_group.company-api-sg.id
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 3724
  end_port = 3724
}


resource "exoscale_security_group_rule" "company-api-sg-rule-8085" {
  type = "INGRESS"
  security_group_id = exoscale_security_group.company-api-sg.id
  protocol = "TCP"
  cidr = "0.0.0.0/0"
  start_port = 8085
  end_port = 8085
}


