#This file exports the account id list from organizations and stores them in the ssm parameter store of aft management account

resource "aws_ssm_parameter" "account_list" {
    count   = length(data.aws_organizations_organization.account_list.accounts[*].id)
    name    = "/nm/aft/account_id/${lower(replace(data.aws_organizations_organization.account_list.accounts[count.index].name, " ", "_"))}"
    type    = "String"
    value   = data.aws_organizations_organization.account_list.accounts[count.index].id
    overwrite = false
}