# 6 - Taking over the world (MUAHAHAHA)

## Happy path

* Verify the that the account is configured with multi-master
* Add a new region to Cosmos DB, which should be the same region as the second resource group that was provided to them
* Deploy any related services to the new region
* Configure the services to only use the Cosmos DB instance within the preferred region. This can be done via the SDK, for example, by setting the `PreferredRegion` value

## Coach's notes

Have attendees perform the following to verify their solution:

* Process for adding their data store to a new region. If the process includes partition management operations, like cloning, splitting, and deleting the physical partitions to create replicas across regions, those steps must also be demonstrated
* The team has deployed their data store to another region with full replication between both regions with little to no delay
* The data generator has been configured with the new Event Hubs connection string. The generator will send the same number of events to both Event Hubs, splitting the load evenly between regions. As such, the team needs to ensure the following:

    * The data generator adds a value to the region field that is either "Region1" or "Region2", sending all "Region1" events to one region and "Region2" events to the other. The team must demonstrate to the coach that an equal number of events are written to both regions. Their options for doing so depend on the characteristics of their NoSQL data store. They can either write a query to count the number of events for each region designation and compare the values, or they can display metrics that show the number of transactions for each region that occurred during the time in which the generator ran
    * Check the stream processing component the team built to extract events from the event hub and write it to their database needs to be configured to only write to the instance that lives in the same region

* The team explains to the coach how, after adding the second region, data durability is improved during regional outages. They should be able to explain the recovery time objective (RTO) and recovery point objective (RPO) and how those values compare to operating in only one region. Also, how data is synchronized to a replica that is affected by a regional outage when it comes back online. The RTO and RPO levels for a multi-region deployment should meet the data durability objectives Contoso has expressed
