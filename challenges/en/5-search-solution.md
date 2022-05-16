# 5 - Improving the search experience

## Happy path

Attendees might attack this problem in one of the following ways:

* Integrate Azure Cognitive Search (or ElasticSearch) to index the title and description fields of the movie data, and allow for full text search against these fields.
* Add faceted search by enhancing the Azure Search Index to index other fields like release date and category.
* Add fuzzy search capabilities to return results for misspelled words.
* Test search API via service interface or a tool like Postman.

## Art of the possible

Teams can use their imagination to creatively add capabilities beyond what the customer has requested. If they are using Azure Cognitive Search, for example, perhaps they could use the built-in Cognitive services AI capabilities to index celebrities or objects found in movie posters, and make them searchable.

## Coach's notes

Have attendees perform the following to verify their solution:

* Perform a search on "" (title).
* Perform a search on "" (description)
* Search for a "" release date
* Search for a misspelled "" title
* Demonstrate a faceted search-based query

## Additional resources

* [Azure Cognitive Search indexing](https://docs.microsoft.com/azure/search/search-what-is-an-index)
* [Elasticsearch in the Azure marketplace](https://azuremarketplace.microsoft.com/marketplace/apps/elastic.elasticsearch)
