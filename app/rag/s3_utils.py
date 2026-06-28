import os
import boto3

BUCKET_NAME = os.getenv(
    "S3_BUCKET_NAME",
    "aws-rag-poc-documents-334455667454"
)

s3 = boto3.client("s3")

def upload_file(file_path, object_name):
    s3.upload_file(
        file_path,
        BUCKET_NAME,
        object_name
    )
