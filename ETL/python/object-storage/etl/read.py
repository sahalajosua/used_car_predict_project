"""
    author      : sahalajosuasinaga@gmail.com
    project     : Final Project Data Expert
    organizer   : G2Academy
    batch       : July
"""

import boto3, awswrangler as wr #type: ignore
import os
import pandas as pd
from dotenv import load_dotenv #type: ignore
from sqlalchemy import create_engine #type: ignore
from io import StringIO # python3; python2: BytesIO 


class ReadData:

    def read_data(self):

        # load dotenv
        load_dotenv()

        # define env aws acces key id
        KEY_ID      = os.environ['key']

        # define env aws secret key
        ACCESS_KEY  = os.environ['acc']

        # define env aws region name
        REGION      = os.environ['reg']



        # inisiasi connection
        endpoint    = boto3.session.Session(
                                    aws_access_key_id = '{abc}'.format(abc=KEY_ID),
                                    aws_secret_access_key = '{abd}'.format(abd=ACCESS_KEY),
                                    region_name = '{abe}'.format(abe=REGION)
                                )
        
        # create dataframe
        dataframe_satu = wr.s3.read_csv(path='s3://final-project-g2academy/raw-data',
                                        boto3_session=endpoint,
                                        path_suffix=".csv"
                                        )

        # save dataframe as csv in S3 bucket
        try:
            dataframe_satu.to_csv("s3://final-project-g2academy/master/data_master.csv",
                                    storage_options={'key'  : '{abf}'.format(abf=KEY_ID),
                                                    'secret': '{abg}'.format(abg=ACCESS_KEY)}, index=False)

            print("Dataframe is saved as CSV in S3 bucket.")

        except:

            print("Dataframe Cannot save to S3 Bucket.")
