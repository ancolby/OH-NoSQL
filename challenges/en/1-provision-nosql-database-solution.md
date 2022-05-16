# 1 - To the cloud

## Happy path

Attendees provision a new Cosmos DB account, using the SQL API, located in one of the resource groups.

## Coach's notes

**Note**: All resources, including documentation for the existing SQL database can be [**found here**](https://github.com/Microsoft-OpenHack/app-modernization-with-nosql_artifacts).

Have attendees perform the following to verify their solution:

* Show the resource in the Azure portal
* Demonstrate how to scale the instance up
* Prove that the schema is flexible (insert different doc types into same collection)
* This challenge should take _no more than_ 1 hour to complete

## Things to watch out for

> Some attendees might want to try and sign of for Atlas through the Azure marketplace. DO NOT LET THEM DO THIS! Atlas costs $25,000 USD/year with a one year commit.

Choosing Cosmos DB is the choice of least friction, and depending on which API attendees choose, the optimal choice for this OpenHack. The following lists potential impact of the various API choices with later challenges:

### Cosmos DB SQL API

The Cosmos DB SQL API has the greatest integration with services, such as Stream Analytics, since Cosmos DB (SQL API) is a built-in output target. Attendees also have an easy way of measuring performance, given that Request Unit costs are exposed either in the portal (queries) or via SDK (for writes). In addition, the [Cosmos DB connector for PowerBI works with the SQL API](https://docs.microsoft.com/azure/cosmos-db/powerbi-visualize).

### Cosmos DB MongoDB API

If your group chooses this, they will lose the ability to have direct output from both Data Factory and Stream Analytics to Cosmos DB. However: They could output to an Azure Function, where they can then take their data and write to Cosmos DB via SDK. It's just one small level of indirection. As for RU charge: query costs should also show up in the portal, but attendees can also run `db.runCommand("getLastRequestStatistics")` via the Mongo shell to get write costs (or do the same via one of the MongoDB SDKs). More info [here](https://docs.microsoft.com/azure/cosmos-db/find-request-unit-charge#azure-cosmos-db-api-for-mongodb). As for PowerBI reports: attendees can _potentially_ use [MongoDB with PowerBI desktop](https://docs.mongodb.com/bi-connector/master/connect/powerbi/). Collections are treated as tables, essentially, via an ODBC connection.

### Cosmos DB Cassandra API

Using this API provides similar challenges to selecting the MongoDB API, regarding writes using an Azure Function as an intermediary. The Cosmos DB docs page previously linked to shows how to extract RU costs from the SDK. See [specific information for Cassandra](https://docs.microsoft.com/azure/cosmos-db/find-request-unit-charge#cassandra-api). As for PowerBI connectivity, the attendees' experience may be hit-or-miss. They could potentially use [a custom connector](https://community.powerbi.com/t5/Desktop/Connecting-PowerBI-to-Azure-Cassandra-CosmosDB-API/td-p/673857). Your table should use this at their own risk.

### Cosmos DB Gremlin API

Like Cassandra, this choice is sub-optimal. Unless someone is already proficient with graph database and Gremlin, you should steer the group from the Gremlin API. There is the same need for an intermediary, when using Data Factory and Stream Analytics. RU consumption is [extractable via the SDK](https://docs.microsoft.com/azure/cosmos-db/find-request-unit-charge#gremlin-api). On the plus side, the Cosmos DB PowerBI connector [supports both the SQL API and the Gremlin API](https://docs.microsoft.com/en-us/azure/cosmos-db/powerbi-visualize).

### Choosing a standalone database

While it is fairly straightforward to install a database within a VM or container, there will be some new technical hurdles, such as:

* When importing data from SQL, your group will find that Data Factory has no way to directly output to native MongoDB, Cassandra, or most NoSQL databases (reference: [source/sink list for ADF](https://docs.microsoft.com/azure/data-factory/copy-activity-overview#supported-data-stores-and-formats)). That means your table would either have to build their own data importer, or use ADF to copy data to an Azure Function, where they can then use a native SDK to write to the database of their choice.
* Performance tuning may be more difficult. This is due to not having Request Units that abstract away physical cost (CPU, RAM, etc.) Instead, attendees will need to perform empirical benchmarking on their VMs. As a result, the cost estimation exercise will likely take significantly longer to complete.
* There will be no native Stream Analytics support. Attendees will need to do a similar trick as described for MongoDB API: output to an Azure Function, then write the aggregates to the database of their choice from within the Azure Function.
* For PowerBI, see the guidance above, regarding native support for various databases.

### Bottom line

Cosmos DB, coupled with SQL API, is going to be the most time-efficient choice. The MongoDB API is likely a good alternative since data will look very similar to Cosmos DB (they'll be able to compare notes with table-neighbors), it's a fairly popular skillset, and with the help of Azure Functions, they should be able to overcome the obstacles posed by Data Factory and Stream Analytics (assuming they go with those tools).
