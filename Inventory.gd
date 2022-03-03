extends Node2D

var inventoryItems = {}
var itemImages = {}

export(Resource) var itemData = null

# Called when the node enters the scene tree for the first time.
func _ready():
	addInventoryItem("alchemy")
	for i in range(100):
		addInventoryItem("alchemy")
	for i in range(100):
		addInventoryItem("artifice")
	for i in range(100):
		addInventoryItem("coin")
	
	addInventoryItem("alchemy")
	addInventoryItem("artifice")
	addInventoryItem("alchemy")
	addInventoryItem("sorcery")
	addInventoryItem("summon")
	addInventoryItem("textbook")
	addInventoryItem("coin")
	addInventoryItem("coin")
	addInventoryItem("mana")

	pass # Replace with function body.

func addInventoryItem(item):
	itemData = Global.items[item]
	if item in inventoryItems.keys():
		inventoryItems[item] += 1
		#print("Got Same Item ============")
	else:
		#print("Got New Item -------------")
		inventoryItems[item] = 1
		itemImages[item] = itemData
	updateInventoryItems()
	
func updateInventoryItems():
	#Essentially removes everything in the inventory (This is so that the positioning updates)
	for child in get_children():
		child.queue_free()
	
	#Re-adds everything back into the inventory
	var counter = 0
	for i in itemImages.keys():
		var itemNode = load("res://Item.tscn").instance()
		itemNode.setup(itemImages[i], inventoryItems[i])
		itemNode.position = Vector2(-(len(inventoryItems.keys())-1)*50 + counter*100, 70)
		add_child(itemNode)
		counter += 1
		

