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

# Executes the effect of the option card selected and clears the board for the next event
func execute(effectData):
	for optionCardNode in eventCardNode.optionCards:
		optionCardNode.queue_free()
	eventCardNode.queue_free()
	var deck = get_node("../Deck/Area2D")
	var hand = get_node("../Hand")
	
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
	if len(effectData.addId) > 0:
		var cardsToAdd = []
		for card in deck.cards:
			for id in effectData.addId:
				if(Global.files[card].id == id):
					cardsToAdd.append(card)
		for card in cardsToAdd:
			deck.cards.add(card)
	#Cards can be added to the deck by tag
	if len(effectData.addTag) > 0:
		var cardsToAdd = []
		for card in deck.cards:
			for tag in effectData.addTag:
				for cardTag in Global.files[card].tags:
					if cardTag == tag:
						cardsToAdd.append(card)
		for card in cardsToAdd:
			deck.cards.add(card)
	
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


# Returns true if there is an active event card on the board
func hasEventCard():
	return is_instance_valid(eventCardNode)

