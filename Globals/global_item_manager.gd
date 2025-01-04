extends Node

var rng = RandomNumberGenerator.new()
var items : Array = JSON.parse_string(FileAccess.get_file_as_string("res://items/items.json"))


# I would still like to add in functionality, for filtering items by their min_level/max_level values.


# Get a signle item ether by ID or item Title
func get_item( val ):
	if typeof( val ) == TYPE_STRING:
		return get_item_by_name( val )
	if typeof( val ) == TYPE_INT:
		return get_item_by_id( val )


# Get a signle item by ID
func get_item_by_id( id ):
	for item in items:
		if item["id"] == id:
			return item
	# If no item matches the id, return an empty dictionary or handle accordingly
	return {}


# Get a single item by Title
func get_item_by_name( val : String ):
	for item in items:
		if item["title"] == val:
			return item
	# If no item matches the title, return an empty dictionary or handle accordingly
	return {}


# Get all items for a given category
func get_category_items( category : String ):
	var results = []
	for item in items:
		if category in item["categories"]:
			results.append(item)
	return results


# Get a random item; optionally pass a category to get a random item from that category
func get_random_item(category : String = ""):
	# Check if category is set if so filter all items by category first
	if category != "":
		items = get_category_items( category )
	
	# Calculate the total drop rate
	var total_drop_rate = 0.0
	for item in items:
		total_drop_rate += item["drop_rate"]

	# Generate a random number between 0 and the total drop rate
	var random_value = randf() * total_drop_rate

	# Select an item based on the random value
	var cumulative_drop_rate = 0.0
	for item in items:
		cumulative_drop_rate += item["drop_rate"]
		if random_value <= cumulative_drop_rate:
			return item

	# This line should never be reached if drop rates sum up correctly, 
	# but it's here as a fallback
	return items.back()


# Get random items setting a min / max value; optionally pass a category to get a random item from that category
func get_random_items(min_count: int = 1, max_count: int = 1, category : String = "") -> Array:
	var result = []
	
	# Check if category is set if so filter all items by category first
	if category != "":
		items = get_category_items( category )

	for _i in range( randi_range( min_count, max_count) ):
		var item = get_random_item( category )
		# To avoid duplicates if needed, you could check if the item is already in result
		# Here, we allow duplicates for simplicity
		result.append(item.duplicate())  # Duplicate to avoid modifying the original array

	return result
