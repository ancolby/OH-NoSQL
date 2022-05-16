# 2 - Migrate the database to the cloud

## Happy path

The preferred migration tool to Cosmos DB is Azure Data Factory, given its ability to perform migrations at scale, along with transformations and orchestration using several actions, if needed. Attendees could use Data Flows to connect to the SQL database, reference each table, apply transformations, and write to a Cosmos DB container(s). They could also choose to build a pipeline and define these actions instead.

Within the transformation steps, a good practice would be to add a new derived field that sets the entity type so different entities within the same container can be identified by type, for querying purposes. Attendees will perform optimizations in the next challenge, so don't expect full denormalization and ideal partition strategies at this point. The main goal is for attendees to perform a _repeatable_ raw migration to their NoSQL database.

## Coach's notes

Have attendees perform the following to verify their solution:

* Show the record counts are the same for each "table" or "content type"
* Destroy all collections, then re-run the migration
* Change the throughput (in Cosmos DB, RUs) for a specific collection

## Things to watch out for

* If you see attendees use the Cosmos DB Migration tool, challenge them on whether the tool will help them create a repeatable migration process, apply data transformations, or denormalize their data if needed (which hints at things to come in the next challenge). They should conclude that the Cosmos DB Migration tool is not the best tool for the job.

* Remind teams that working with ADF leads to potential race conditions.  The last one to publish changes wins.  Perhaps integrate with GitHub to mitigate these issues.  

## Resources

* [Copy data to or from Azure Cosmos DB (SQL API) by using Azure Data Factory](https://docs.microsoft.com/azure/data-factory/connector-azure-cosmos-db)
* [Import Data into MongoDB](https://docs.mongodb.com/guides/server/import/)
