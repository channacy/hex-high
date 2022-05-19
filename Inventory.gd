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
			
	#add scholarship
	if inventoryItems["alchemy"] >= 25 and inventoryItems["summon"] >= 25 and inventoryItems["sorcery"] >= 25 and inventoryItems["artifice"] >= 25:
		deck.cards.append("scholarship")
	#remove scholarship
	if inventoryItems["alchemy"] < 25 and inventoryItems["summon"] < 25 and inventoryItems["sorcery"] < 25 and inventoryItems["artifice"] < 25:
		while deck.cards.find("scholarship") != -1:
			deck.cards.erase("scholarship")
			
	#add social
	if inventoryItems["fatigue"] >= 10:
		deck.cards.append("social")
	#remove social
	if inventoryItems["fatigue"] < 10:
		while deck.cards.find("social") != -1:
			deck.cards.erase("social")
			
	#add trade1
	if inventoryItems["coin"] >= 10:
		deck.cards.append("trade1")
	#remove trade1
	if inventoryItems["coin"] < 10:
		while deck.cards.find('trade1') != -1:
			deck.cards.erase('trade1')
		
	#add trade2
	if inventoryItems["coin"] >= 15:
		deck.cards.append("trade2")
	#remove trade2
	if inventoryItems["coin"] < 15:
		while deck.cards.find('trade2') != -1:
			deck.cards.erase('trade2')
		
	#add trade3
	if inventoryItems["coin"] >= 2:
		deck.cards.append("trade3")
	#remove trade3
	if inventoryItems["coin"] < 2:
		while deck.cards.find('trade3') != -1:
			deck.cards.erase('trade3')
		
	
