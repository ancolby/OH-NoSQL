# 4 - Events are the center of our universe

## Background story

Contoso would like to add new features to their solution to support the [event sourcing pattern](https://docs.microsoft.com/azure/architecture/patterns/event-sourcing) as customers place orders. They want to gain insights on which movies are doing well, which categories are most popular, and see near-real-time information showing the number of orders and total revenue within different time periods. This information would initially be used for understanding patterns of consumer behavior, but they want the components in place they can use to capture and display other types of telemetry in the future. They are excited about this potential innovation, but need your guidance to steer them down the right path.

These events will be streamed in near real time from the website to the back end that collects them, which should be able to handle high volumes of ingest with minimal latency and no loss of events.

Contoso would like to create report style views summarizing the activity of users on the website. As new events arrive they would like to see some of the statistics update in near real time. Other statistics they want to update during specific windows, like hourly and daily.

Examples of these statistics include:

- Count of orders placed for this hour.
- Summary of activity (number of orders and total revenue) for this day so far.
- Top 10 most popular movies purchased of all time.
- Most popular movie categories.

Additionally, Contoso would like to ensure they have a layer of caching that reduces reads against the data store when the commonly retrieved movie categories are accessed. They would like to start out by caching categories in their POC and decide how to proceed from there. Although movie categories do not change often, Contoso wants automated cache invalidation/refreshing for the caching layer you design. In their current deployment, they had explored doing this but got stuck figuring out how they could invalidate the cache when the underlying records had been changed, and do that in response to the change. They were particularly concerned with ensuring that the cache would be properly adjusted, no matter how the change to the categories was made (e.g., through an admin website or a direct edit against the database).

## Technical details

Contoso is receiving the order data from the data generator application provided for you below. You will download and launch the program and configure it to send the telemetry to your database. This application is designed to send events in the form of JSON documents to Azure Event Hubs, which are also provided for you in the lab environment. The generator application contains a configuration file for adding your event hub connection information. Once you have configured the generator with your connection information, you must determine a solution to retrieve JSON messages from the event hub and store the data in your data store.

With orders flowing into your data store, you now need to devise a method to have one or more consumers react to changes in your data store. Contoso stated that they want to implement an event sourcing pattern, where events flow from one or more sources into the data store, which in turn allows one or more sources to react to the new data changes for downstream processing. It is in this end of the pipeline where you will need to create your consumers that fulfill the requirements outlined in the background story above.

The following is the schema for the JSON payload sent to Event Hubs:

```json
{
    "type": "object",
    "properties": {
        "Region": {
            "type": "string"
        },
        "OrderDate": {
            "type": "string"
        },
        "FirstName": {
            "type": "string"
        },
        "LastName": {
            "type": "string"
        },
        "Address": {
            "type": "string"
        },
        "City": {
            "type": "string"
        },
        "State": {
            "type": "string"
        },
        "PostalCode": {
            "type": "string"
        },
        "Country": {
            "type": "string"
        },
        "Phone": {
            "type": "string"
        },
        "SMSOptIn": {
            "type": "boolean"
        },
        "SMSStatus": {
            "type": "string"
        },
        "Email": {
            "type": "string"
        },
        "ReceiptUrl": {
            "type": "string"
        },
        "Total": {
            "type": "number"
        },
        "PaymentTransactionId": {
            "type": "string"
        },
        "HasBeenShipped": {
            "type": "boolean"
        },
        "Details": {
            "type": "array",
            "items": {
                "type": "object",
                "properties": {
                    "Email": {
                        "type": "string"
                    },
                    "ProductId": {
                        "type": "integer"
                    },
                    "Quantity": {
                        "type": "integer"
                    },
                    "UnitPrice": {
                        "type": "number"
                    }
                },
                "required": [
                    "Email",
                    "ProductId",
                    "Quantity",
                    "UnitPrice"
                ]
            }
        }
    }
}
```

## Contoso Video resources

Contoso Video has provided a data generator for the orders. [**Follow these instructions**](https://github.com/Microsoft-OpenHack/app-modernization-with-nosql_artifacts/tree/main/DataGenerator) to download and configure the data generator.

## Success criteria

- The data generator successfully sends orders into Event Hubs, and you create a process to consume the events and write the data into your database.
- The team's event sourcing should produce the following results:

    - Create and populate materialized views for reporting, using one or both of the following criteria:

        - Top 10 most popular movies purchased of all time.
        - Most popular movie categories.

    - Save aggregate data over time windows (x per hour, day, etc.), using one or both of the following criteria:

        - Count of orders placed for this hour.
        - Summary of activity (number of orders and total revenue) for this day so far.

    - Create at least one dashboard or report that displays the materialized views created in this challenge.
    - Implement some form of caching of categories. You do *not* have to modify the web application in any way to show this.
    - Implement dynamic cache invalidation when changes are made to movie categories. Cache should be updated when movie categories are inserted, updated, or deleted. This can be tested by attendees by executing queries against the cache, update one or more category items, then re-execute their cache query to ensure the cache was refreshed.

## Tips

- The collection to which you write the streaming events may benefit from a different indexing strategy than the other collections. You will want to evaluate your partitioning strategy (should time-based virtual partitions be used, or just a simple key?), consistency level, throughput, and other factors as well.
- Use whichever stream processing technology you are comfortable with to process data flowing through Event Hubs and writes it to the database. However, pay attention to Contoso's concerns about having a resilient solution where they don't lose data in the case of a regional failure. This means what you use needs to be able to scale out to meet demand, and each instance or node will need to be able to write checkpoints as they process data so they can continue where left off if they fail or shut down.

## Resources

- [Event sourcing pattern](https://docs.microsoft.com/azure/architecture/patterns/event-sourcing)
- [Stream Analytics](https://azure.microsoft.com/services/stream-analytics/)
- [Event Hubs](https://azure.microsoft.com/services/event-hubs/)
- [Cosmos DB change feed](https://docs.microsoft.com/azure/cosmos-db/change-feed)
- [Azure Serverless with Azure Logic Apps and Azure Functions](https://docs.microsoft.com/azure/logic-apps/logic-apps-serverless-overview)
- [Azure Cosmos DB .NET SDK for SQL API](https://docs.microsoft.com/azure/cosmos-db/sql-api-sdk-dotnet)
- [Azure Cosmos DB Java SDK for SQL API](https://github.com/Azure/azure-cosmosdb-java)
- [Azure Event Hubs Client for Java](https://github.com/Azure/azure-event-hubs-java)
- [Stream data into Azure Databricks using Event Hubs](https://docs.microsoft.com/azure/azure-databricks/databricks-stream-from-eventhubs)
8 [Command Reference: Redis Cache](https://redis.io/commands)  
- [Synchronizing your Cosmos DB into Azure Redis Cache using Azure Functions](https://www.chapsas.com/synchronising-your-cosmos-db-into-azure-redis-cache-using-azure-functions/)  
- [Serverless event-based architectures with Azure Cosmos DB and Azure Functions](https://docs.microsoft.com/en-us/azure/cosmos-db/change-feed-functions)
- [Mulitple Cosmos Db Triggers](https://docs.microsoft.com/en-us/azure/cosmos-db/how-to-create-multiple-cosmos-db-triggers)  
- [Troubleshooting issues with Cosmos DB and Azure Functions](https://docs.microsoft.com/en-us/azure/cosmos-db/troubleshoot-changefeed-functions)  
- [Competing Consumers](https://docs.microsoft.com/en-us/azure/architecture/patterns/competing-consumers)
