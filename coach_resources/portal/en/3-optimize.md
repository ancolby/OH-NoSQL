# 3 - Optimize NoSQL design

## Background story

Aside from the crucial steps to modernize by moving their data and application to the cloud, at the top of Contoso's mind is whether they can meet the higher demand of exponential growth.  This growth will be driven by the movie catalog update with new international content and the audience that goes with it. This growth concern drives them to pursuing optimal performance levels and fueling their desire to unlock new capabilities and even more growth through innovation. They are looking to you as the expert in this area. Yes, they know how their new data store gives them flexibility in their data schema, but what are the fundamental design decisions they need to make within their data layer to stay performant in the future without scaling up to the point of spending more than they should?

## Technical details

The team will begin evaluating query patterns as stated within the guide and as observed within the sample web application and related artifacts.

At a high level, the following is a set of specific query patterns that Contoso has explained they want to make sure continue to work in the new design, are performant, and are cost-optimized for the following *anticipated* query volumes:

- Retrieve list of top 10 movies by popularity (home page): *~500 requests/second*
- Retrieve list of last 10 movies by release date: *~75 requests/second*
- Page through lists of movies: *~30 requests/second*
- Retrieve list of categories: *~500 requests/second*
- Filter movies by category: *~200 requests/second*
- Retrieve details for a specific movie: *~160 requests/second*
- Retrieve orders with details showing products with quantities: *~10 requests/second*
- Add a movie to the shopping cart: *~5 requests/second*
- Complete a purchase transaction: *~2 requests/second*

Contoso currently has 85,000 concurrent users during peak time, but would like to plan for 5 million concurrent users.

Perform sizing exercise to determine anticipated scale requirements. Optimize the schema design to reduce scale requirements if possible.

## Success Criteria

- The team has implemented optimizations and demonstrated to their coach an improvement in query performance, and/or cost per query. *Application modification is not required*.

    - Estimate the cost per query for reads and writes, then use this information to calculate the throughput the design would need at the anticipated scale.
    - Investigate how to scale capacity if needs change hour by hour, then share this plan with the coach.

- The team has created different data models for their database to optimize for the high-level queries above, and to implement denormalization as needed.

## Tips

- Compare the partition strategy developed in the previous challenge to what you think it should be now. Has your plan evolved? Are there any instances where having more than one partition to support different read-heavy workloads make sense?
- When optimizing your schema, consider the following:

    - The optimal partition key has been applied at the collection level for each collection.
    - Related documents/entities are collocated under the same partition. These should be entities that are most often retrieved together.
    - If appropriate, some related data is embedded. For example, if you return a product and want to include some information about the category (which may be stored in a different partition) without retrieving the entire category document. In other words, denormalization.
    - As needed, virtual partition key values are used.
    - Adjust indexing appropriate for read or write-optimized workloads.
    - The most appropriate consistency model is selected based on usage patterns within the web application, and through testing.

- Take care to consider the differences in modeling data for different data stores.

    - Avoid treating collections like tables and understand how multiple entity types can possibly be stored within the same collection.

## Resources

- [Choosing a Data Model](https://docs.microsoft.com/azure/architecture/data-guide/big-data/non-relational-data)
- [Data Modeling for NoSQL](https://docs.microsoft.com/azure/cosmos-db/modeling-data)
- [Partitioning in Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/partitioning-overview)
- [Modeling and partitioning a real-world example on Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/how-to-model-partition-example)
- [Trimming strings with Data Flow Expression Functions](https://docs.microsoft.com/en-us/azure/data-factory/data-flow-expression-functions#trim)
- [All Data Flow Expression Functions](https://docs.microsoft.com/en-us/azure/data-factory/data-flow-expression-functions)
- [Serverless event-based architectures with Azure Cosmos DB and Azure Functions](https://docs.microsoft.com/en-us/azure/cosmos-db/change-feed-functions)
- [Mulitple Cosmos Db Triggers](https://docs.microsoft.com/en-us/azure/cosmos-db/how-to-create-multiple-cosmos-db-triggers)  
- [Troubleshooting issues with Cosmos DB and Azure Functions](https://docs.microsoft.com/en-us/azure/cosmos-db/troubleshoot-changefeed-functions)  
- [Competing Consumers](https://docs.microsoft.com/en-us/azure/architecture/patterns/competing-consumers)
