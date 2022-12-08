"""
    author      : sahalajosuasinaga@gmail.com
    project     : Final Project Data Expert
    organizer   : G2Academy
    batch       : July
"""

import boto3 #type: ignore
import os
from dotenv import load_dotenv #type: ignore


class CreateBucket:


    def create_bucket(self):

        # load dotenv
        load_dotenv()

        # define env aws acces key id
        KEY_ID      = os.environ['key']

        # define env aws secret key
        ACCESS_KEY  = os.environ['acc']

        # define env aws region name
        REGION      = os.environ['reg']

        # inisiasi connection
        endpoint    = boto3.client(
                                    's3',
                                    aws_access_key_id = '{abc}'.format(abc=KEY_ID),
                                    aws_secret_access_key = '{abd}'.format(abd=ACCESS_KEY),
                                    region_name = '{abe}'.format(abe=REGION)
                                )

        try:

            bucket_name  =  "final-project-g2academy"

            response     = endpoint.create_bucket(Bucket=bucket_name)

            print(response)

            print("success create bucket")

        except:

            print("cannot create bucket")