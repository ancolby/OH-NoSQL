# 2 - Migrate the database to the cloud

## Background story

Now that the team has provisioned a new database, Contoso Video wants to start migrating their data. They hope that all the data can be migrated without loss, but are not sure how it should be restructured, if at all, to work within the new data store. Contoso informed the team that their website performs satisfactorily in general, but once a customer selects an item to get more detailed information, the page often loads slowly for customers during peak hours. This drives some to become frustrated and to shop on other websites instead.

Contoso is hoping that by migrating their data to the new cloud database, they can independently scale up throughput for product browsing to alleviate these long wait times without affecting the cost or performance of their checkout functionality.

## Technical details

The team will now begin migrating from the SQL database to the new data store. Migrate all data to the new database to establish a baseline model. This data is primarily queried by category on the main product page, and by specific product when a user selects an item to view. User interactions are stored as they browse the catalog, view items, and perform shopping cart-related actions. The store should be able to support these query patterns with minimal latency. The team can assume that all product categories have a similar amount of items, that they are all searched at similar rates, and that new products are introduced infrequently.

In this challenge, the goal is to perform a raw migration. The team will optimize their database design in the next challenge. Because of this, the team must ensure they have a repeatable migration process when they complete this challenge.

## Contoso Video resources

Contoso has provided the team with a copy of their web application and data (with test data only!). These resources are pre-deployed for the team to review a recent version of the web application and SQL Server database. Contoso believes it is important for the team to understand where they are today in order to *plan for the future*. The web application source code is also available for review, if so desired.

**Note**: All resources, including documentation for the existing SQL database can be [**found here**](https://github.com/Microsoft-OpenHack/app-modernization-with-nosql_artifacts).

The team is free to complete the following tasks to review the current application state:

- Open the deployed website, browse the movie catalog, add a movie to the cart.
- Review the database and relational schema.
- Review key queries in the application code.

The SQL database credentials are:

**Username**: openhackadmin
**Password**: Password123

<!-- At this point, the team should have their selected appropriate partitioning strategy based on initial observations of data models and query patterns from the previous challenge. -->

## Success Criteria

- All data is migrated to the new database. This is a **raw migration** with no expectation of optimization at this stage (but could potentially be used for optimizations in the future).
- The team has created and executed queries to count records of each type (Category, Item, Orders, etc.) to validate migration success.
- The team has a repeatable migration process that will allow them to re-migrate the data as needed during the optimization challenge.
- The team must explain to the coach how they would scale this workload up during peak hours.

## Resources

- [Copy data to or from Azure Cosmos DB (SQL API) by using Azure Data Factory](https://docs.microsoft.com/azure/data-factory/connector-azure-cosmos-db)
- [Import Data into MongoDB](https://docs.mongodb.com/guides/server/import/)
