#
# API Gateway ID (required)
# e.g., ${var.aws_api_gateway_rest_api.<API>.id}
#

variable "rest_api_id" {}

#
# Resource ID (required)
# e.g., ${var.aws_api_gateway_resource.<RESOURCE>.id}
#

variable "resource_id" {}

#
# HTTP Method ID (required)
# e.g., ${var.aws_api_gateway_method.<METHOD>.id}
#

variable "http_method" {}

#
# Name of Lambda function (required)
# Point to name of a lambda function attached to your account and region
# e.g., 'my_awesome_lambda_func'
#

variable "lambda_name" {}

#
# Account ID (required)
# ID of AWS account e.g., 99999999999
#

variable "account_id" {}

#
# Region (required)
# e.g., us-east-1
#

variable "region" {}

#
# Velocity template used to capture params from request and send to lambda (optional)
# more info: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-mapping-template-reference.html
#

variable "integration_request_template" {
  default = "{}"
}

#
# Velocity template used to capture params sent to response from lambda (optional)
# more info: http://docs.aws.amazon.com/apigateway/latest/developerguide/api-gateway-mapping-template-reference.html
#

variable "integration_response_template" {
  default = "#set($inputRoot = $input.path('$')){}"
}

#
# Request Parameters
# A map of request query string parameters and headers that should be passed to the integration.
#

variable "request_parameters" {
  default = {}
}

#
# Method Request model (optional)
# Name of model used for method request.
# Reference the model by name e.g., `Empty`, `Error` or create a custom model and reference that by name
#

variable "request_model" {
  default = "Empty"
}

#
# Method Response model (optional)
# Name of model used for method Response.
# Reference the model by name e.g., `Empty`, `Error` or create a custom model and reference that by name
#

variable "response_model" {
  default = "Empty"
}

#
# Error Template (optional)
# Velocity template used to deliver errors to response
# Assumes all responses uses the same error template.
#

variable "integration_error_template" {
  default = <<EOF
#set ($errorMessageObj = $util.parseJson($input.path('$.errorMessage')) {
  "message" : "$errorMessageObj.message"
}
EOF
}

#
# Authorization used on request (optional)
# i.e., "IAM_AM" | "NONE"
#

variable "authorization" {
  default = "NONE"
}
