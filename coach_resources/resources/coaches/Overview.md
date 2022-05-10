# NoSQL OpenHack

## Scenarios

The challenges in this NoSQL OpenHack are based on a typical customer path that begins with building a traditional monolithic web application that uses a relational data store, to re-platforming and re-architecting their solution to a modern, cloud-native, microservices-focused solution. Though the emphasis of the challenges are aimed toward the database, the migration path from a relational data store to a NoSQL data store that is highly scalable and ready for global distribution, serves as a solid foundation for application modernization efforts that would normally occur in parallel. That said, there is no expectation of the attendees to modernize the supplied web application, but they are free to do so at their discretion (and within time constraints).

There are a set of challenges focused on optimizing the NoSQL database design to maximize performance and minimize cost. These exercises are important tools to help attendees dig deep into these concepts and learn through experimentation and research. One of the primary complaints users have when using NoSQL databases is cost. This is oftentimes due to implementers incorrectly optimizing and right-sizing the database, leading to lackluster performance or out of control spend.

Another set of important exercises are focused on implementing an [event sourcing pattern](https://docs.microsoft.com/azure/architecture/patterns/event-sourcing). Attendees are challenged to ingest streaming data, then automatically notify consumers as events arrive so they can perform some downstream processing, such as populating materialized views and real-time dashboards. These challenges help attendees think beyond typical CRUD operations they may be used to for their databases and applications, and consider how they can handle the rising velocity, variety, and volume of data in today's Big Data landscape. The event sourcing pattern is also very common in distributed, microservices-based applications, which fits nicely with the Contoso Video customer scenario.

## Target audience

The event targets developers, data engineers, and database administrators who have experience working with NoSQL databases. Ideally, these attendees want to learn more about migrating an existing relational database to NoSQL in Azure, and modernization through a compliment of Azure services.

Participants should have experience working with NoSQL data stores of any type along with working knowledge on performance optimization, including partitioning, indexing, and denormalization. Familiarity with relational data structures is also helpful but not required. Experience with programming languages such as C#, Java, and Python will help them advance more quickly.

## Goals

On top of general OpenHack goals to improve Azure services, improve documentation, and evangelize these technologies, there are other goals we are focused on:

* How it is possible to migrate from a relational database to NoSQL
* How best to optimize the database through a good partition strategy, indexing, denormalization, materialized views, throughput tuned to varying workloads, etc.
* Implement an event sourcing pattern for optimization and scalable, distributed processing of streaming data in real time
* Expand search capabilities by enabling full-text, fuzzy, and faceted search against the data store
* Move from storing and serving data from a single region to multiple regions worldwide to bring data and services closer to the end user, no matter where they live

## Challenges summary

| Title | Challenge Overview | Possible Technologies |
|-------|--------------------|-----------------------|
| 1 - To the cloud | Provisioning a NoSQL database in Azure, using the success criteria and customer needs as a guide | Cosmos DB, Mongo DB, Cassandra, Raven DB, etc.
| 2 - Migrating the database to the cloud | Create a repeatable process to migrate from the supplied SQL database to the selected NoSQL database, validate the migration through queries, and explain to the coach how the database can be scaled | Azure Data Factory, mongoimport tool
| 3 - Optimize NoSQL design | Estimate the cost per query for reads and writes, as well as query performance. Use best practices for optimizing the database after evaluating common queries and workloads, then show a measurable improvement after optimization is complete. Attendees may need to migrate their data once again | Cosmos DB SDK, metrics/telemetry
| 4 - Events are the center of our universe | Use the event sourcing pattern on user order data that flows into Event Hubs from the data generator, to kick off downstream consumers as data is written to the database. Use these events to create materialized views, real-time dashboards, and cache invalidation | Event Hubs, Cosmos DB, Azure Functions, Apache Spark, Azure Stream Analytics, Power BI, Apache Storm, Kafka
| 5 - Improving the search experience | Enable full-text, fuzzy, and faceted searching capabilities on the database | Azure Cognitive Search, Elasticsearch
| 6 - Taking over the world (MUAHAHAHA) | Add the NoSQL database to a new region with full replication between both regions, ensure the same number of writes occur within the regions, and that the data durability objectives expressed by Contoso Video are met | Event Hubs, Cosmos DB, Azure Functions, Apache Spark, Azure Stream Analytics

## What does a coach do

### Hacker teams

* Facilitate collaboration​
* Set expectations​
* Ask leading questions, offer resources instead of answers​
* Encourage creativity​
* Problem solve: technical and interpersonal

### Manage sentiment

* Content will be challenging and **frustrating** at times​
* Let them be challenged but not blocked​
* Check in frequently and raise any issues or what is working well

### Coach team

* Share challenges, solutions​
* Leverage **Teams** channel​
* Collect **daily feedback** for end-of-day coaches sync​
* **Take breaks** and check in with the coaches around you

## End of day sync

For the internal coaches sync at the end of each day, there are three questions you should ask each of your teams:

* What did you accomplish today?
* What was the biggest challenge today?
* Is there anything we can do better tomorrow?

## Some things to keep in mind

* No step-by-step instructions or "right" answer​
* Not all pain points are removed​
* Everyone should be learning and having fun. That includes YOU!​
* Keep Challenge Content and reference solutions private​
* Teams probably won't complete all challenges. Even though we have a leaderboard, it's important that they learn and not cut corners, it's ok for them to stay in the early challenges, and the objective is NOT to finish all challenges

## Code of conduct

Microsoft's mission is to empower every person and every business on the planet to achieve more. This includes at OpenHack where we seek to create a respectful, friendly, and inclusive experience for all participants.​

As such, we do not tolerate harassing or disrespectful behavior, messages, images, or interactions by any event participant, in any form, at any aspect of the program including business and social activities, regardless of location.​

We do not tolerate any behavior that is degrading to any gender, race, sexual orientation or disability, or any behavior that would violate Microsoft's Anti-Harassment and Anti-Discrimination Policy, Equal Employment Opportunity Policy, or Standards of Business Conduct. In short, the entire experience at the venue must meet our culture standards.​

We encourage everyone to assist in creating a welcoming and safe environment. Please report any concerns, harassing behavior, or suspicious or disruptive activity to venue staff, the event host or owner, or the nearest security guard or event staff. ​

Microsoft reserves the right to refuse admittance to, or remove any person from OpenHack at any time in its sole discretion.

We ask you to take a leadership role in helping to ensure this event is a success for your peers and our customers. How you can help:​

* **Prioritize the satisfaction of our customers and partners above all else**. Extend your kindness and courtesy to all other attendees and help event staff as needed.​
* Ensure all attendees are **respectful and supportive of other attendees**. If someone is being excluded, ignored or interrupted, please take time to politely direct the group to be respectful. E.g. “I don't think they have finished their thought”​
* **Immediately report any incidents** to the Event Crew that are harassing or disrespectful regardless of gender, race, sexual orientation or disability.​
* Remember that while there will be a number of Microsoft employees hacking through the challenges. The majority of attendees are external. **Please refrain from discussing any Microsoft confidential information at the event or ancillary activities. ​**
* Do not use open forums with Microsoft SMEs (e.g. lunchtime presentations) to ask internal or "Hardball" questions. Microsoft attendees should instead find private time to ask these questions or provide feedback.
