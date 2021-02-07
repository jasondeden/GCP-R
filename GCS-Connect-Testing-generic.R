#Google Cloud Connection Setup and Test

#This file assumes you have created a service account in your GCP project with owner rights
#and have downloaded the key to your local system. It also assumes you have enabled the
#Google Cloud Storage (GCS) and BigQuery APIs and, if you want to see output for list buckets,
#have created at least one GCS bucket. It further assumes you have duplicated the covid19_aha dataset
#available from the public datasets into your own project.

#If you haven't already done so, install the packages below by uncommenting and running the lines.
#install.packages("googleAuthR")
#install.packages("googleCloudStorageR")
#install.packages("bigrquery")

#Load the packages
library(googleAuthR)
library(googleCloudStorageR)
library(bigrquery)

#Point gar_auth_service to the local path of the service account key and set the scope.
#The cloud-platform scope includes both GCS and BigQuery, so probably want to leave it as-is.

gar_auth_service("/path/to/your/service/key.json", scope = "https://www.googleapis.com/auth/cloud-platform")
#gar_token_info()  #if you want to check and make sure you have an active token now

#Set a projectId variable to your project ID, not the shortened project name
projectId <- "<your-project-id>"

#Confirm that you have access to the cloud storage functions
gcs_list_buckets(projectId)

#BigQuery requires an additional authentication via bq_auth(path = "/the/same/key/as/before.json")
bq_auth(path = "/path/to/your/service/key.json")

#Craft a SQL statement that queries your dataset table and store as a variable
sql <- "SELECT county_name, state_name, total_hospital_beds FROM `covid_19_aha.hospital_beds`"

#Run bq_project_query, specifying your project ID and the SQL string you want to run
#and store it as a variable. Note - due to query caching, you are only billed for the first
#query you run if this is run multiple times for testing.
tb <- bq_project_query(projectId, sql)

#Download the first 10 results of your query
bq_table_download(tb, max_results = 10)

#We have configured RStudio for GCP access and confirmed connectivity to Cloud Storage and BigQuery