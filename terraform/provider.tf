data "aws_caller_identity" "current" {}

data "aws_ssm_parameter" "ct_management-account-id" {
    name = "/aft/account/ct-management/account-id"
}

provider "aws" {
    alias = "ct_management_account"
    assume_role {
        role_arn = "arn:aws:iam::${data.aws_ssm_parameter.ct-management-account-id.value}:role/AWSAFTExecution"
    }
    region = "ap-south-1"
}

data "aws_organizations_organization" "account_list" {
    provider = aws.ct_management_account
}