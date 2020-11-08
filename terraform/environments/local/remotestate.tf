
# resource "aws_s3_bucket" "terraform_state" {
#   bucket = "${local.environment_tag}-terraform-kafka-configuration"
#   region = local.region

#   versioning {
#     enabled = true
#   }

#   lifecycle {
#     prevent_destroy = true
#   }
# }

# resource "aws_dynamodb_table" "terraform_statelock" {
#   attribute {
#     name = "LockID"
#     type = "S"
#   }

#   hash_key       = "LockID"
#   name           = "${local.environment_tag}-terraform-kafka-configuration-statelock"
#   read_capacity  = 1
#   write_capacity = 1
# }

