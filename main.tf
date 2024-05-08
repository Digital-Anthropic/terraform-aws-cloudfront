module "terraform_s3_cloudfront_lambda_func" {
  source                = "./s3-cloudfront-module"
  bucket_name           = var.bucket_name 
  cloudfront_price_class = var.cloudfront_price_class
  lambda-arn = {
    "lambda-arn" = {
      lambda_arn = module.lambda_edge.lambda_arn
    }
  }
  depends_on = [module.lambda_edge]
}

module "lambda_edge" {
  source                = "./lambda-module"
}

output "bucket_endpoint" {
  value = module.terraform_s3_cloudfront_lambda_func.bucket_endpoint
}

output "cloudfront_domain_name" {
  value = module.terraform_s3_cloudfront_lambda_func.cloudfront_domain_name
}

moved {
  from = module.mkdocs
  to = module.terraform_s3_cloudfront_lambda_func
}
