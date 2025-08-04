    resource "aws_s3_bucket" "aiwflow_logs" {
      bucket = "dami-arflow-celery-logs"
      tags = {
        Name        = "dami-celery-project"
        Environment = "Dev"
      }
    }