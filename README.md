# End-to-End Data Engineering Project Using Bixi Live GBFS Feed
![Architecture Diagram Design](images/architecture_diag.png)
## Data Ingestion Process

### Creating Linked Services in Azure Data Factory
- Configured HTTP linked services to connect to the Bixi Live GBFS Feed URLs.
- Defined two linked services: one for station information and another for station status.


### Pipeline Creation in Azure Data Factory
- Designed a data pipeline to automate the ingestion process.

#### Activities in the Pipeline:
- **HTTP Connector Activity**: Set up to fetch data from the station information URL and the station status URL.
- **Copy Activity**: Configured to copy the fetched data into JSON datasets.

![Pipeline Design](images/data_pipeline.png)

### Data Storage in Azure Data Lake
- Defined datasets in Azure Data Lake to store the JSON data.
- Stored the station information and station status data in their respective JSON datasets.

### Scheduling and Monitoring
- Scheduled the pipeline to run at regular intervals to ensure the datasets are updated with the latest information.
- Set up a trigger to run every 5 minutes, updating the files with new data from the Bixi Live GBFS feed.
- Monitored the pipeline for successful execution and handled any errors or issues during the data ingestion process.


