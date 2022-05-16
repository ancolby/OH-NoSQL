# 4 - Events are the center of our universe

## Happy path

Attendees might attack this problem in one of the following ways:

* Use the Change Feed from Cosmos DB, responding with an Azure Function that forwards the data to an Event Hub instance. The Event Hub is consumed by an Azure Stream Analytics windowed query whose summarized output is written back to Cosmos DB, to Power BI or to another endpoint that supports the display of the aggregated data.  
* Create a materialized view for the aggregate statistics. Again, using the Change Feed on Cosmos DB, they would use an Azure Function to process each batch of events. This batch of events is grouped and aggregated. The current statistics are queried and the aggregated results are added to the current values and saved back to Cosmos DB in a materialized view.
* Write entities to a different container, which has a different partition key. This would provide two or more partition keys over the same data, which could save in throughput costs, despite data duplication.
* Potentially use Spark (using Databricks, HDInsight, etc.) and the Cosmos DB Spark connector library to read from the change feed, perform aggregates, visualize data within notebooks, etc.
* Set up a Redis cache in Azure, then populate it with categories.
* Alternately, create a container partitioned by id, then create a cache using a key/value store.
* Another approach is to create a single document that contains values for each category.
* Use the Change Feed to invalidate or update items in the cache when movie categories are changed.

## Coach's notes

Have attendees perform the following to verify their solution:

* Show data flowing into one event hub (main metrics blade)
* Show the counts of events increasing in the collection
* Show that the cache is updated when movie categories are inserted, updated, or deleted. This can be tested by attendees by executing queries against the cache, update one or more category items, then re-execute their cache query to ensure the cache was refreshed.
* Show a dashboard (like in Power BI) and/or reports with the following results:

    * Materialized views showing one or both of the following criteria:

        * Top 10 most popular movies purchased of all time.
        * Most popular movie categories.

    * Save aggregate data over time windows (x per hour, day, etc.), using one or both of the following criteria:

        * Count of orders placed for this hour.
        * Summary of activity (number of orders and total revenue) for this day so far.

## Things to watch out for

* If there is an error in Stream Analytics, it could be caused by not including the partition key field when outputting the data to Cosmos DB. It has to match and be case-sensitive. You will see this when you run the query and you receive an error.
* If attendees are using Stream Analytics to query the data coming from the data generator (through Cosmos DB, to the change feed, to a processor like Azure Functions, into Event Hubs, then into Stream Analytics), they may have difficulty figuring out how to parse the array of Order Details within an Order record. They should use Stream Analytic's array functions, like `GetArrayElement`, `GetArrayElements`, `GetArrayLength`, and the `APPLY` operator, as [documented here](https://docs.microsoft.com/azure/stream-analytics/stream-analytics-parsing-json#array-data-types).
* If attendees are using Stream Analytics to write to Cosmos DB, make sure attendees do **not** specify the `id` property on the Cosmos DB output settings when they create it. This is an optional field and, if you include it, then Stream Analytics expects you to pass a value for the property. If they don't, it will set the `id` value to the value you apply to the partition key field. This can cause problems depending on the data they are writing to the partition key field. If you do not specify the `id` property in the output settings, then Cosmos DB will automatically set the document `id` value to a GUID.
* Data might not appear right away in Power BI when attendees use Power BI as an output in their Stream Analytics query. There is an initial delay when you first start sending data to a Power BI dataset from Stream Analytics. This delay can last up to 5-19 minutes before you even see the dataset. Once you see the dataset in Power BI, you should be able to access the data. To troubleshoot, try the following:
    * Make sure the data generator is still running.
    * Make sure the order data is being written to Cosmos DB.
    * Make sure the Cosmos DB change feed consumer (such as Azure Functions) is connecting to the correct Cosmos DB container (that the orders are being written to) and is properly functioning with no errors. You can use the live view of Application Insights to help determine this, along with custom logging to App Insights.
    * Try outputting from the Stream Analytics query to a different sink to see if the query is working.
* People might have issues with connecting to Event Hubs from their data generator. They should do the following to obtain the correct connection string to their event hub:
    * Open the Event Hubs namespace in the location 1 resource group (default name is openhack1).
    * Open the `telemetry` event hub that was already created for them.
    * Create a new **shared access policy** and grant it both **Send** and **Listen** policies (Listen is for if they reuse this connection string from a consumer).
    * Copy the connection string from the new shared access policy.
* If attendees are writing a .NET-based Azure Function to trigger off the Cosmos DB change feed, make sure they are using the **latest version** of the [`Microsoft.Azure.Cosmos` SDK](https://www.nuget.org/packages/Microsoft.Azure.Cosmos/) (>= 3.6.0), using the latest version of the Azure Functions project type in either Visual Studio 2019 or Visual Studio Code. If they do not use the latest version of the Cosmos DB SDK, they may encounter an issue when the function creates the `leases` container in Cosmos DB if it does not exist, _and_, if they have the throughput set to the database level in Cosmos DB instead of the container level. This is because older versions of the SDK do not assign a partition key when it creates the container, since the fixed-size container that does not require a partition key existed whent the SDK was written.
    * Attendees can obtain useful starter code for creating their Azure Function that is triggered by the change feed and writes to Event Hubs here: <https://cosmosdb.github.io/labs/dotnet/labs/08-change_feed_with_azure_functions.html>.
    * Here is a snippet of the function code they can **adapt** to their scenario:

```csharp
using System.Collections.Generic;
using Microsoft.Azure.Documents;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Host;
using Microsoft.Extensions.Logging;
using Microsoft.Azure.EventHubs;
using System.Threading.Tasks;
using System.Text;

namespace ChangeFeedFunctions
{
    public static class AnalyticsFunction
    {
        private static readonly string _eventHubConnection = "<your-connection-string>";
        private static readonly string _eventHubName = "carteventhub";

        [FunctionName("AnalyticsFunction")]
        public static async Task Run([CosmosDBTrigger(
            databaseName: "StoreDatabase",
            collectionName: "CartContainer",
            ConnectionStringSetting = "DBConnection",
            CreateLeaseCollectionIfNotExists = true,
            LeaseCollectionName = "analyticsLeases")]IReadOnlyList<Document> input, ILogger log)
        {
            if (input != null && input.Count > 0)
            {
                var sbEventHubConnection = new EventHubsConnectionStringBuilder(_eventHubConnection)
                {
                    EntityPath = _eventHubName
                };

                var eventHubClient = EventHubClient.CreateFromConnectionString(sbEventHubConnection.ToString());

                var tasks = new List<Task>();

                foreach (var doc in input)
                {
                    var json = doc.ToString();

                    var eventData = new EventData(Encoding.UTF8.GetBytes(json));

                    log.LogInformation("Writing to Event Hub");
                    tasks.Add(eventHubClient.SendAsync(eventData));
                }

                await Task.WhenAll(tasks);
            }
        }
    }
}
```

* Teams using Java on a Mac have reported that the default environment variable for Java has been set incorrectly to the windows version: `%JAVA_HOME%` instead of the correct `$JAVA_HOME` that would be expected.  If a team is using a mac and working with Java, ask them to ensure they have validated that their tooling is referencing the correct java home environment variable.

## Preferred solution diagram

Here is an architecture diagram of the preferred solution up to this point:

![Preferred solution diagram](preferred-solution-diagram.png "Preferred solution")

## Additional resources

* [Event sourcing pattern](https://docs.microsoft.com/azure/architecture/patterns/event-sourcing)
* [Stream Analytics](https://azure.microsoft.com/services/stream-analytics/)
* [Event Hubs](https://azure.microsoft.com/services/event-hubs/)
* [Cosmos DB change feed](https://docs.microsoft.com/azure/cosmos-db/change-feed)
* [Azure Serverless with Azure Logic Apps and Azure Functions](https://docs.microsoft.com/azure/logic-apps/logic-apps-serverless-overview)
* [Azure Cosmos DB .NET SDK for SQL API](https://docs.microsoft.com/azure/cosmos-db/sql-api-sdk-dotnet)
* [Azure Cosmos DB Java SDK for SQL API](https://github.com/Azure/azure-cosmosdb-java)
* [Azure Event Hubs Client for Java](https://github.com/Azure/azure-event-hubs-java)
* [Stream data into Azure Databricks using Event Hubs](https://docs.microsoft.com/azure/azure-databricks/databricks-stream-from-eventhubs)
* [Command Reference: Redis Cache](https://redis.io/commands)  
* [Synchronizing your Cosmos DB into Azure Redis Cache using Azure Functions](https://www.chapsas.com/synchronising-your-cosmos-db-into-azure-redis-cache-using-azure-functions/)  
* [Serverless event-based architectures with Azure Cosmos DB and Azure Functions](https://docs.microsoft.com/en-us/azure/cosmos-db/change-feed-functions)
* [Mulitple Cosmos Db Triggers](https://docs.microsoft.com/en-us/azure/cosmos-db/how-to-create-multiple-cosmos-db-triggers)  
* [Troubleshooting issues with Cosmos DB and Azure Functions](https://docs.microsoft.com/en-us/azure/cosmos-db/troubleshoot-changefeed-functions)  
* [Competing Consumers](https://docs.microsoft.com/en-us/azure/architecture/patterns/competing-consumers)
