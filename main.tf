resource "aws_api_gateway_method" "ResourceMethod" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${var.http_method}"
  authorization = "${var.authorization}"
  request_parameters = "${var.request_parameters}"
  request_models = { "application/json" = "${var.request_model}" }
}

resource "aws_api_gateway_integration" "ResourceMethodIntegration" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_method.ResourceMethod.http_method}"
  type = "AWS"
  uri = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/arn:aws:lambda:${var.region}:${var.account_id}:function:${var.lambda_name}/invocations"
  integration_http_method = "POST"
  request_templates = { "application/json" = "${var.integration_request_template}" }
}

resource "aws_api_gateway_integration_response" "ResourceMethodIntegration200" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_method.ResourceMethod.http_method}"
  status_code = "${aws_api_gateway_method_response.ResourceMethod200.status_code}"
  response_parameters = {
    "method.response.header.Access-Control-Allow-Origin" = "'*'"
  }
  response_templates = { "application/json" = "${var.integration_response_template}" }
}

resource "aws_api_gateway_integration_response" "ResourceMethodIntegration400" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_method.ResourceMethod.http_method}"
  status_code = "${aws_api_gateway_method_response.ResourceMethod400.status_code}"
  response_templates = {
    "application/json" = "${var.integration_error_template}"
  }
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "'*'" }
}

resource "aws_api_gateway_method_response" "ResourceMethod200" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_method.ResourceMethod.http_method}"
  status_code = "200"
  response_models = { "application/json" = "${var.response_model}" }
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "*" }
}

resource "aws_api_gateway_method_response" "ResourceMethod400" {
  rest_api_id = "${var.rest_api_id}"
  resource_id = "${var.resource_id}"
  http_method = "${aws_api_gateway_method.ResourceMethod.http_method}"
  status_code = "400"
  response_models = { "application/json" = "Error" }
  response_parameters = { "method.response.header.Access-Control-Allow-Origin" = "*" }
}
