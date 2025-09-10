SSM_PATH="/dami_celery/project"  

ENV_FILE=".env"

# fetch from SSM → write KEY=VALUE lines (properly quoted) to .env
aws ssm get-parameters-by-path \
  --path "$SSM_PATH" \
  --with-decryption \
  --recursive \
  --output json \
  --query 'Parameters[].{Name:Name,Value:Value}' \
| jq -r '.[] | "\(.Name|split("/")[-1])=\(.Value|@sh)"' > "$ENV_FILE"

chmod 600 "$ENV_FILE"

# load into current shell (exports all vars from the file)
set -a
. "$ENV_FILE"
set +a
