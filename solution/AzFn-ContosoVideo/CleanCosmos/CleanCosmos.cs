using System;
using System.IO;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using Microsoft.Azure.WebJobs;
using Microsoft.Azure.WebJobs.Extensions.Http;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Logging;
using Newtonsoft.Json;
using Microsoft.Azure.Cosmos;

namespace ContosoVideo
{
    public static class CleanCosmos
    {
        [FunctionName("CleanCosmos")]
        public static async Task<IActionResult> Run(
            [HttpTrigger(AuthorizationLevel.Function, "post", Route = null)] HttpRequest req,
            ILogger log)
        {
            log.LogInformation("Clean Cosmos processing request....");

            // Create a container with a partition key and provision 400 RU/s manual throughput.
            string connectionString = Environment.GetEnvironmentVariable("CosmosConnectionString");
            string databaseId = Environment.GetEnvironmentVariable("ContosoVideoRawDatabaseId");
            CosmosClient client = new CosmosClient(connectionString);
            Database database = await client.CreateDatabaseIfNotExistsAsync(databaseId);

            string requestBody = await new StreamReader(req.Body).ReadToEndAsync();
            dynamic data = JsonConvert.DeserializeObject(requestBody);

            // Validate input and delete containers
            foreach (dynamic item in data)
            {
                string name = item?.name;
                string partitionKey = item?.partitionKey;

                if (string.IsNullOrEmpty(name) && string.IsNullOrEmpty(partitionKey))
                {
                    return new BadRequestResult();
                }
                else
                {
                    Container container = database.GetContainer(name);
                    if (container != null)
                    {
                        try
                        {
                            log.LogInformation($"Attempting to delete container: {name}");
                            await container.DeleteContainerAsync();
                        }
                        catch
                        {

                        }
                    }
                }    
            }

            foreach (dynamic item in data)
            {
                string name = item?.name;
                string partitionKey = item?.partitionKey;

                ContainerProperties containerProperties = new ContainerProperties()
                {
                    Id = name,
                    PartitionKeyPath = "/" + partitionKey
                };

                log.LogInformation($"Creating container: {name} with partition key: {partitionKey}");
                await database.CreateContainerIfNotExistsAsync(containerProperties);
            }

            return new OkResult();
        }
    }
}
