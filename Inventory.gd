extends Node2D

var inventoryItems = {}


# Called when the node enters the scene tree for the first time.
func _ready():
	addInventoryItem("Study Books")
	addInventoryItem("Study Books")
	addInventoryItem("Gold Coins")
	addInventoryItem("Mana")
	#addInventoryItem("Knowledge")
	#addInventoryItem("Something Else")
	pass # Replace with function body.

func addInventoryItem(item):
	var itemNode = item
	#itemNode.setup("res://Item.tscn", 1)
	if itemNode in inventoryItems.keys():
		inventoryItems[itemNode] += 1
		print("Got Same Item ============")
	else:
		print("Got New Item -------------")
		inventoryItems[itemNode] = 1
	updateInventoryItems()
	
func setupItem(item, numItems):
	print("Setup One item")
	
func updateInventoryItems():
	for child in get_children():
		child.queue_free()
	var num = len(inventoryItems.keys())
	print(num)
	for i in num:
		var itemNode = load("res://Item.tscn").instance()
		itemNode.position = Vector2(-(num-1)*50 + i*100, 5)
		add_child(itemNode)
		print("Added One Card to Inventory")

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
