extends Node2D

var inventoryItems = {}
var itemImages = {}

export(Resource) var itemData = null

# Called when the node enters the scene tree for the first time.
func _ready():
	for item in Global.items:
		inventoryItems[item] = 0
		itemImages[item] = Global.items[item]
	updateInventoryItems()

	pass # Replace with function body.
	
func addInventoryItem(item, quantity):
	itemData = Global.items[item]
	inventoryItems[item] += quantity
	updateInventoryItems()
	
func removeInventoryItem(item, quantity):
	itemData = Global.items[item]
	inventoryItems[item] = max(inventoryItems[item] - quantity, 0)
	updateInventoryItems()
	
func updateInventoryItems():
	#Essentially removes everything in the inventory (This is so that the positioning updates)
	for child in get_children():
		child.queue_free()
	
	# Counts the number of non-zero inventory items
	var numOfItems = 0
	for i in inventoryItems.keys():
		if inventoryItems[i] > 0:
			numOfItems += 1
	
	#Re-adds everything back into the inventory
	var counter = 0
	for i in itemImages.keys():
		if inventoryItems[i] > 0:
			var itemNode = load("res://Item.tscn").instance()
			itemNode.setup(itemImages[i], inventoryItems[i])
			itemNode.position = Vector2(-(numOfItems-1)*50 + counter*100, 70)
			add_child(itemNode)
			counter += 1

# Updates the deck with cards based on the player's inventory
func updateResourceConditionals():
	var deck = get_node("../../Deck/Area2D")
	
	# Adding fatigue penalties
	if inventoryItems["fatigue"] >= 5:
		deck.cards.append("fatiguePenalty")
		
	# Removing fatigue penalties
	if inventoryItems["fatigue"] < 5:
		while deck.cards.find("fatiguePenalty") != -1:
			deck.cards.erase("fatiguePenalty")
	
	# Adding writeup penalties
	if inventoryItems["writeups"] >= 5:
		deck.cards.append("writeupsPenalty")
		
	# Removing writeup penalties
	if inventoryItems["writeups"] < 5:
		while deck.cards.find("writeupsPenalty") != -1:
			deck.cards.erase("writeupsPenalty")
