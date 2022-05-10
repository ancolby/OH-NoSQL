# 6 - Taking over the world (MUAHAHAHA)

## Background story

Now that Contoso Video has improved discoverability of products on their site through improved search capabilities, they want to plan on how they will bring their catalog to new worldwide customers, thanks to their online movie distribution deal with the conglomerate of overseas movie production companies. Their distribution agreement dictates a gradual rollout to new markets, the first test market being in western Europe. Since Contoso Video is currently a United States-based company, expanding to Europe means that they not only need to replicate their data overseas, they also need to move related components such as their website, streaming, and search services to those regions as well. Contoso does not want users in any region to experience any form of latency resulting from making network requests that span an ocean. They also, do not want to have to explicitly manage how the data in the two regions stay in sync.

The other benefit Contoso Video is hoping to gain from operating in multiple regions is data durability during regional outages. They want to be able to route all traffic to an available region in case one of the regions goes down. They also want to know that any writes that occurred during a regional outage are synchronized to the affected region after it recovers. The durability they desire for their database after moving to multiple regions, is < 15 minutes for their recovery point objective (RPO), and 0 for their recovery time objective (RTO).

## Technical details

The team will create a new node or replica of their NoSQL data store within a new Azure region. They must ensure that data can be written to both regions and not rely on writing to just the original region. Contoso's requirements are clear about limiting customer interactions to their own region and not spanning an ocean. Users who are close to a region should only read and write to that region, for optimal performance. Data needs to be replicated to both regions with little noticeable delay. They want to ensure that, when a customer writes data, they should be able to retrieve the updated record with a read that immediately follows the write. If a customer adds an item to their cart, for instance, they should see the added item when they refresh the page. Contoso is worried that if this level of consistency is not achieved, it can be jarring for their customers.

All of the related Azure services that the team has provisioned within the original resource group need to be provisioned in the new region. If possible, each application and service needs to be configured to read/write to the data store located in the same region. Since the outcome of this exercise is a proof of concept, there is no need to implement region-bound traffic routing, high availability, or disaster recovery.

## Success criteria

- The team demonstrates to the coach their process for adding their data store to a new region. If the process includes partition management operations, like cloning, splitting, and deleting the physical partitions to create replicas across regions, those steps must also be demonstrated.
- The team has deployed their data store to another region with full replication between both regions with little to no delay.
- The data generator has been configured with the new Event Hubs connection string. The generator will send the same number of events to both Event Hubs, splitting the load evenly between regions. As such, the team needs to ensure the following:

    - The stream processing component the team built to extract events from the event hub and write it to their database needs to be configured to only write to the instance that lives in the same region.
    - The data generator adds a value to the `region` field that is either "Region1" or "Region2", sending all "Region1" events to one region and "Region2" events to the other. The team must demonstrate to the coach that an equal number of events are written to both regions. Their options for doing so depend on the characteristics of their NoSQL data store. They can either write a query to count the number of events for each `region` designation and compare the values, or they can display metrics that show the number of transactions for each region that occurred during the time in which the generator ran.

- The team explains to the coach how, after adding the second region, data durability is improved during regional outages. They should be able to explain the recovery time objective (RTO) and recovery point objective (RPO) and how those values compare to operating in only one region. Also, how data is synchronized to a replica that is affected by a regional outage when it comes back online. The RTO and RPO levels for a multi-region deployment should meet the data durability objectives Contoso has expressed.

## Tips

- Evaluate whether the consistency model you selected when hosting your database in a single region is still the best choice for multiple write regions. Is there any benefit to applying a different consistency model? Is the consistency model compatible when using multiple regions?

## Resources

- [Replicated data consistency explained through baseball](https://www.microsoft.com/research/publication/replicated-data-consistency-explained-through-baseball/?from=http%3A%2F%2Fresearch.microsoft.com%2Fpubs%2F157411%2Fconsistencyandbaseballreport.pdf)
- [Session guarantees for weakly consistent replicated data](https://dl.acm.org/citation.cfm?id=383631)
- [Consistency tradeoffs in modern distributed database system design: CAP is only part of the story](https://www.computer.org/csdl/magazine/co/2012/02/mco2012020037/13rRUxjyX7k)
- [Probabilistically bounded staleness for practical partial quorums](https://vldb.org/pvldb/vol5/p776_peterbailis_vldb2012.pdf)
- [Eventually consistent - revisited](https://www.allthingsdistributed.com/2008/12/eventually_consistent.html)
- [Guarantees associated with consistency levels in Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/consistency-levels#guarantees-associated-with-consistency-levels)
- [Consistency, availability, and performance tradeoffs in Azure Cosmos DB](https://docs.microsoft.com/azure/cosmos-db/consistency-levels-tradeoffs)
