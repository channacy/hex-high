extends Control

# The currently active event card node
var eventCardNode = null

# Called when the node enters the scene tree for the first time.
func _ready():
	#loadEvent("test", false)
	print_tree()

# Creates an event card node and initializes it
func loadEvent(eventCardId, faceUp):
	if is_instance_valid(eventCardNode):
		eventCardNode.queue_free()
	eventCardNode = load("res://EventCard.tscn").instance()
	eventCardNode.setup(eventCardId, faceUp)
	add_child(eventCardNode)
	
func checkCost(cost):
	var inventory = get_node("../InventoryNode/Inventory")
	if inventory.inventoryItems["alchemy"] >= cost.alchemy:
			if inventory.inventoryItems["artifice"] >= cost.artifice:
				if inventory.inventoryItems["summon"] >= cost.summon:
					if inventory.inventoryItems["sorcery"] >= cost.sorcery:
						if inventory.inventoryItems["textbook"] >= cost.textbook:
							if inventory.inventoryItems["coin"] >= cost.coin:
								if inventory.inventoryItems["mana"] >= cost.mana:
									return true
	else: 
		return false

# Executes the effect of the option card selected and clears the board for the next event
func execute(effectData):
	for optionCardNode in eventCardNode.optionCards:
		optionCardNode.queue_free()
	eventCardNode.queue_free()
	var deck = get_node("../Deck/Area2D")
	var hand = get_node("../Hand")
	var inventory = get_node("../InventoryNode/Inventory")  
	# Removes cards by id from the deck
	if len(effectData.removeId) > 0:
		var cardsToRemove = []
		for card in deck.cards:
			for id in effectData.removeId:
				if(Global.files[card].id == id):
					cardsToRemove.append(card)
		for card in cardsToRemove:
			deck.cards.erase(card)
	
	# Removes cards by tag from the deck
	if len(effectData.removeTag) > 0:
		var cardsToRemove = []
		for card in deck.cards:
			for searchTag in effectData.removeTag:
				for cardTag in Global.files[card].tags:
					if cardTag == searchTag:
						cardsToRemove.append(card)
		for card in cardsToRemove:
			deck.cards.erase(card)
	
#When an option card that adds cards is selected, it adds the correct cards to the deck
	#Cards can be added to the deck by id
	if len(effectData.addId) > 0: #if there is an effect added to the array based on Id
		for id in effectData.addId:  #iterates through the array 
			for card in Global.files:  #search through each card in dictionary 
				if (id == Global.files[card].id): #if something in the array equals something in the dictionary
					deck.cards.append(id)  #add this to the end of the deck which is an array of strings
			
	#Cards can be added to the deck by tag
	if len(effectData.addTag) > 0:  #if there is an effect added to the array based on Id
		for card in Global.files:  #search through dictionary
			for tag in effectData.addTag:  #search through each tag in the array 
				for cardTag in Global.files[card].tags: #search through each tag in the array of tags
					if cardTag == tag:  #if the tag in the array of tags that is within the dictionary equals tag in effectData.addTag
						deck.cards.append(Global.files[card].id) #add it to the deck which is an array of strings
						
	#Cards can be added to the hand by tag
	if len(effectData.addHandTag) > 0:
		for card in Global.files:
			for tag in effectData.addHandTag: #checks the tag we want to add from the current option card
				for cardTag in Global.files[card].tags: #checks tag from each event card
					if cardTag == tag: #if tag from our option card matches an event card tag
						hand.addCard(Global.files[card].id) #the event card is added to the hand
	
	#Cards can be added to the hand by id
	if len(effectData.addHandId) > 0:
		for card in Global.files:
			for id in effectData.addHandId:
				if id == Global.files[card].id: #checks if the id we want to add and the event card's id matches
					hand.addCard(id) #if it does, the event card is added to the hand
					
	

	# Removes cards by id from the hand
	if len(effectData.removeHandId) > 0:
		var cardsToRemove = []
		for cardNode in hand.eventCardNodes:
			var card = cardNode.cardData
			for id in effectData.removeHandId:
				if(card.id == id):
					cardsToRemove.append(cardNode)
		for card in cardsToRemove:
			card.queue_free()
			hand.removeCard(card)
	
	# Removes cards by tag from the hand
	if len(effectData.removeHandTag) > 0:
		var cardsToRemove = []
		for cardNode in hand.eventCardNodes:
			var card = cardNode.cardData
			for searchTag in effectData.removeHandTag:
				for cardTag in card.tags:
					if cardTag == searchTag:
						cardsToRemove.append(cardNode)
		for card in cardsToRemove:
			card.queue_free()
			hand.removeCard(card)
			
	#add resources based on option cards
	if len(effectData.addResources) > 0:
		for i in range(0, len(effectData.numResources)): 
			for x in range(0, effectData.numResources[i]):
				for y in Global.items:
					if effectData.addResources[i] == Global.items[y].id:
						inventory.addInventoryItem(effectData.addResources[i])
						print(effectData.addResources[i]) 
						
	#inventory.addInventoryItem("coin")
	#print(effectData.addResources)
	#print(effectData.numResources)
# Returns true if there is an active event card on the board
func hasEventCard():
	return is_instance_valid(eventCardNode)

