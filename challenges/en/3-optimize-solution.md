# 3 - Optimize NoSQL design

## Happy path

Attendees might do the following:

* Potentially modify their automated migration process, then run it again to import data based on these modifications
* Denormalize datasets
* Execute several queries, then use the Cosmos DB metrics to evaluate the throughput cost and identify any partition hot spots
* Duplicate data and store with different sort orders or keys
* Adjust indexing
* Adjust partition key selected
* Evaluate their choice of consistency model
* Explore Autopilot for Cosmos DB
* Potentially have the attendees partition the same data two different ways (by category to populate the main search page and by id to populate the individual product details pages- no need to build these pages just the requirements that would drive the decision)

## Coach's notes

Have attendees perform the following to verify their solution:

* Show the original throughput starting point, then show a changed throughput target
* Show a dynamic change of the throughput levels during runtime
* Show you how they have denormalized data, such as embedding order details in to the orders document
* Alternately show you the plan for breaking apart document types into other partitions, but this is probably rare

## Estimating pricing

If attendees are using Cosmos DB, they can use the following link as a resource: [Estimate RU/s with Capacity Planner](https://docs.microsoft.com/en-us/azure/cosmos-db/estimate-ru-with-capacity-planner). If they use this tool, they should keep the following in mind:

* The Azure Cosmos capacity calculator assumes point reads (a read of a single item, e.g. document, by ID and partition key value) and writes for the workload. That said, only use this to _estimate capacity for writes_.
* Have them set the *Reads/second per region at peak* value to 0, then set the anticipated writes/second value to whatever the anticipated query volumes list shows in the attendee guide. For best results, they can upload a sample document (JSON).

For calculating reads, have attendees execute queries in the Cosmos DB data explorer, then select the Query Stats tab to see the number of RU/s consumed. Or, they can obtain the RU cost by [using one of the Cosmos DB SDKs](https://docs.microsoft.com/en-us/azure/cosmos-db/find-request-unit-charge)

> Since we are dealing with a small number of records, because we don't want the migration to take too long, one way to force more physical partitions so you can demonstrate the performance impact of having multiple physical partitions, is to temporarily increase the RU/s for a container to 50,000. For instance, you can do this on the container that contains the categories, then query by category name.

## Things to watch out for

* The migration process and transformation process should be double checked to ensure that id values are trimmed so that no trailing spaces will be imported into cosmos.

<!-- ## Resources

- TODO: The resources on how to effectively design for this pattern will be critical at this point!
- Autopilot -->  

## Additional resources

* [Modeling and partitioning a real-world example on Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/how-to-model-partition-example)
* [Migrating Relational Data with one-to-few relationships into Azure Cosmos DB SQL API](https://devblogs.microsoft.com/cosmosdb/migrating-relational-data-with-one-to-few-relationships-into-azure-cosmos-db-sql-api/)
* [Denormalizing via embedding when migrating relational data from SQL to Cosmos DB](https://medium.com/@ArsenVlad/denormalizing-via-embedding-when-copying-data-from-sql-to-cosmos-db-649a649ae0fb)
* [Serverless event-based architectures with Azure Cosmos DB and Azure Functions](https://docs.microsoft.com/en-us/azure/cosmos-db/change-feed-functions)
* [Mulitple Cosmos Db Triggers](https://docs.microsoft.com/en-us/azure/cosmos-db/how-to-create-multiple-cosmos-db-triggers)  
* [Troubleshooting issues with Cosmos DB and Azure Functions](https://docs.microsoft.com/en-us/azure/cosmos-db/troubleshoot-changefeed-functions)  
* [Competing Consumers](https://docs.microsoft.com/en-us/azure/architecture/patterns/competing-consumers)
