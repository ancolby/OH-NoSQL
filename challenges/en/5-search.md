# 5 - Improving the search experience

## Background story

Contoso Video has mentioned customers have expressed frustration that the interface only allows them to find movies by browsing recent or top movies, or browsing by category. Customers have indicated they would love to be able find movies by title or even better, by their synopsis. Contoso developers have mentioned they could easily accomplish this with the full text search capabilities in Microsoft SQL Server, but when it comes to NoSQL databases they are uncertain how to proceed. Beyond full-text search, they are interested in seeing if they could add other filters to help users quickly narrow the results.

One more issue about searching that Contoso Video brought up is that some of the movie titles are difficult to spell. They want to enable fuzzy searching so results are discovered, even if misspelled words are included in the search criteria.

## Technical details

The team will now implement full-text searching capabilities by creating an index on the title and description fields. They need to determine whether they can use the new database to natively support full-text search, or some other service that connects to the database and maintains its own indexes. The team will also add indexes against other fields, providing a search experience that integrates both full-text searching and faceted searching against the movie catalog.

## Success criteria

- Indexing is applied to the movie title and description fields which enables full text searching against these fields.
- Additional fields are indexed, such as release date and category, creating a single search layer that provides several options for searching the movie catalog.
- Fuzzy searching capability is added to the movie title and description fields.
- Perform a faceted search.

**Note**: The team can demonstrate full-text, fuzzy, and faceted searching through either the search API service interface (if available), or a tool like Postman.

## Tips

- Consider how search indexing impacts your overall architecture design. Be able to answer the question as to whether it is best to maintain search indexes outside of the database, or if the indexing and search capabilities can be handled entirely by your chosen database engine. What are the pros and cons of each approach if feasible?

## Resources

- [Azure Cognitive Search indexing](https://docs.microsoft.com/azure/search/search-what-is-an-index)
- [How to index Cosmos DB data using an indexer in Azure Cognitive Search](https://docs.microsoft.com/azure/search/search-howto-index-cosmosdb?toc=/azure/cosmos-db/toc.json&bc=/azure/cosmos-db/breadcrumb/toc.json)
- [Elasticsearch in the Azure marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/elastic.elasticsearch)
