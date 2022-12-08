"""
    author      : sahalajosuasinaga@gmail.com
    project     : Final Project Data Expert
    organizer   : G2Academy
    batch       : July
"""

# relative import
from etl import ( 
    CreateBucket, ReadData, RegexData
)


if __name__ == '__main__':

    run_data = RegexData()
    run_data.regex_data()