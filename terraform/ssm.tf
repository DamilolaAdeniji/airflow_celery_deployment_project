resource "aws_ssm_parameter" "AIRFLOW__CELERY__BROKER_URL" {
  name  = "/dami_celery_project/AIRFLOW__CELERY__BROKER_URL"
  type  = "String"
  value =  "redis://:@${module.ec2_instance_redis.public_ip}:6379/0"
}

resource "aws_ssm_parameter" "AIRFLOW__DATABASE__SQL_ALCHEMY_CONN" {
  name  = "/dami_celery/project/AIRFLOW__DATABASE__SQL_ALCHEMY_CONN"
  type  = "SecureString"
  value = "postgresql+psycopg2://${aws_db_instance.airflow_metadata_db.username}:${aws_db_instance.airflow_metadata_db.password}@${aws_db_instance.airflow_metadata_db.endpoint}/${aws_db_instance.airflow_metadata_db.db_name}"
}

resource "aws_ssm_parameter" "CELERY_RESULTS_BACKEND" {
  name  = "/dami_celery/project/CELERY_RESULTS_BACKEND"
  type  = "SecureString"
  value = "db+postgresql://${aws_db_instance.airflow_metadata_db.username}:${aws_db_instance.airflow_metadata_db.password}@${aws_db_instance.airflow_metadata_db.endpoint}/${aws_db_instance.airflow_metadata_db.db_name}"
}