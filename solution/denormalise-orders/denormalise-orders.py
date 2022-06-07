from azure.cosmos import exceptions, CosmosClient, PartitionKey
import json

# Initialize the Cosmos client
endpoint = "https://cdb-contoso-video.documents.azure.com:443/"
key = 'ZDprP2gssJJ9C4P4zGg3nn40ziDdwilbJ5c0lVhIK4gpj6253enCAlx3kekXL6hJtENCGy7MkvesgZUQupCjig=='

# <create_cosmos_client>
client = CosmosClient(endpoint, key)
# </create_cosmos_client>

source_database_name = 'contoso-video-raw'
orders_container_name = 'Orders'
order_details_container_name = 'OrderDetails'

target_database_name = 'contoso-video'
items_container_name = 'Item'
target_container_name = 'Orders'

source_database = client.get_database_client(source_database_name)
target_database = client.get_database_client(target_database_name)

orders_container = source_database.get_container_client(orders_container_name)
order_details_container = source_database.get_container_client(order_details_container_name)

items_container = target_database.get_container_client(items_container_name)
target_orders_container = target_database.get_container_client(target_container_name)

orders = []
for order in orders_container.query_items(
    query='SELECT DISTINCT * FROM Orders c',
    enable_cross_partition_query=True):
    
    order['items']=[]
    
    for order_item in order_details_container.query_items(
        query='SELECT c.ProductId, c.Quantity, c.UnitPrice FROM OrderDetails c WHERE c.OrderId=' + str(order['OrderId']),
        enable_cross_partition_query=True):
        
        for item_details in items_container.query_items(
            query='SELECT c.ItemId, c.ProductName, c.ImdbId, c.Description, c.ImagePath, c.ThumbnailPath, c.UnitPrice, c.CategoryId, c.Popularity, c.OriginalLanguage, c.ReleaseDate, c.VoteAverage, c.AddToCartCount, c.BuyCount, c.ViewDetailsCount, c.VoteCount, c.CategoryName, c.CategoryDescription FROM Item c WHERE c.ItemId =' + str(order_item['ProductId']),
            enable_cross_partition_query=True):

            orderItem = item_details
            orderItem['Quantity'] = order_item['Quantity']
            orderItem['UnitPrice'] = order_item['UnitPrice']

            order['items'].append(orderItem)
    
    orders.append(order)

for order in orders:
    target_orders_container.upsert_item(order)