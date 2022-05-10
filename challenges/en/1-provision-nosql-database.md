# 1 - To the cloud

## Background story

Contoso Video currently runs their web application with a backend SQL database on a combination of dedicated and co-located servers through a local, non-global hosting provider. They are concerned about the long-term cost and the time and effort of keeping up with operating system and database patching, backup and restore management time. In the future, they will want to scale the workload geographically.

Contoso Video has had performance and scale issues with the on-premises database. They have provisioned an over-sized server and are hoping it will meet their immediate needs but are worried about future growth. They would like the ability to scale the database instance up and down as needed without the up-front investment in hardware.

Finally, since Contoso is interested in capturing clickstream telemetry from users, they want a database that can handle high-throughput and that will enable them to build an event sourcing pattern to react to incoming data in real-time.

One concern Contoso Video has is how they will replicate data across global instances. Can they enable their web applications that are deployed in the same region as a database instance to write only to that regional instance? If so, how will all those instances resolve data consistency and synchronize without creating conflicts?

## Technical details

The team has the freedom during the OpenHack to choose the solution they believe will best fit Contoso Video's needs. However, the team must be able to explain the thought process behind the decisions to the team's coach.

## Success criteria

- Select and provision a database with the following characteristics:

    - Enables a simplified process for scaling up and down
    - Supports the event sourcing pattern where changes to the data store trigger events that can be processed by any number of listening components in near real-time
    - Supports a flexible schema with a multi-region, global distribution

- Store any arbitrary record in the database.

## Resources

### Ramp Up

- [What Are NoSQL Databases?](https://azure.microsoft.com/overview/nosql-database/)
- [Event sourcing pattern](https://docs.microsoft.com/azure/architecture/patterns/event-sourcing)
- [Event sourcing with Cosmos DB](https://daniel-krzyczkowski.github.io/Event-Sourcing-With-Azure-Cosmos-Db-Change-Feed/)  

### Choose Your Tools

- [Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/introduction)
- [Mongo DB Atlas](https://www.mongodb.com/cloud/atlas/azure-mongodb)
