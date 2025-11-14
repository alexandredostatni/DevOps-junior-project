#!/bin/bash
echo "Iniciando LocalStack..."
localstack start -d

echo "Aguardando serviços AWS..."
localstack wait -t 60

echo "Criando bucket S3 via AWS CLI local"
awslocal s3 mb s3://devops-artefatos