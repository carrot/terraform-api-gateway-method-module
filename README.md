# Terraform API Gateway Method Module

Terraform module for creating a serverless architecture in API Gateway. This module can be used to resource methods attached to your API Gateway resources to call lambda functions with a few variables exposed see [variables.tf](https://github.com/carrot//terraform-api-gateway-method-module/blob/master/variables.tf).

## Caveats

This module makes a few assumptions for simplicity:

1. You are resourcing API gateway to be used to access Lambda functions as part of a serverless API.
2. Your requests/responses are all in JSON
3. You only require one error response template across your entire API Gateway instance.

## Example Useage
```

# Create a resource

resource "aws_api_gateway_resource" "users" {
  rest_api_id = "${aws_api_gateway_rest_api.<API_NAME>.id}"
  parent_id = "${aws_api_gateway_rest_api.<API_NAME>.root_resource_id}"
  path_part = "users"
}

# Call the module to attach a method along with its request/response/integration templates
# This one creates a user.

module "UsersPost" {
  source  = "github.com/carrot/terraform-api-gateway-method-module"
  rest_api_id = "${aws_api_gateway_rest_api.<API_NAME>.id}"
  resource_id = "${aws_api_gateway_resource.users.id}"
  http_method = "POST"
  lambda_name = "create_user_lambda_funciton"
  account_id = "1234567890"
  region = "us-east-1"
  integration_request_template = "#set($inputRoot = $input.path('$')){}"
  integration_response_template = "#set($inputRoot = $input.path('$')){}"
  integration_error_template = "#set ($errorMessageObj = $util.parseJson($input.path('$.errorMessage')) {\"message\" :\"$errorMessageObj.message\"}"
  authorization = "AWS_IAM"
}
```

Need CORS enabled? check out [https://github.com/carrot/terraform-api-gateway-cors-module](https://github.com/carrot/terraform-api-gateway-cors-module)

## More info
[Terraform - API Gateway](https://www.terraform.io/docs/providers/aws/r/api_gateway_rest_api.html)

