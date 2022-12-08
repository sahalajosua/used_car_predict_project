"""
    author      : sahalajosuasinaga@gmail.com
    project     : Final Project Data Expert
    organizer   : G2Academy
    batch       : July
"""

import boto3, awswrangler as wr #type: ignore
import os
import re
import pandas as pd
from dotenv import load_dotenv #type: ignore
from sqlalchemy import create_engine #type: ignore
from io import StringIO # python3; python2: BytesIO 


class RegexData:

    def regex_data(self):

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
        data        = wr.s3.read_csv(path='s3://final-project-g2academy/master/data_master.csv',
                                     boto3_session=endpoint
                                        )

        # regex to get price from line_text column
        data['price'] = data['line_text'].apply(lambda x: re.findall(r'\((Rp.*?)\)', x))
        data["price"]=data["price"].astype(str).str.replace("[\]\[]", '').\
                                        replace('\'', '', regex=True).\
                                            replace('Rp ', '', regex=True).\
                                                replace('\.', '', regex=True)


        # save dataframe as csv in S3 bucket
        try:
            data.to_csv("s3://final-project-g2academy/master/data_master_price.csv",
                        storage_options={'key'  : '{abf}'.format(abf=KEY_ID),
                                        'secret': '{abg}'.format(abg=ACCESS_KEY)}, index=False)

            print("Regex is saved as CSV in S3 bucket.")

        except:

            print("Regex Cannot save to S3 Bucket.")