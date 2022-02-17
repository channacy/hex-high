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
	
	# Removes cards by id
	if len(effectData.removeId) > 0:
		var cardsToRemove = []
		for card in deck.cards:
			for id in effectData.removeId:
				if(Global.files[card].id == id):
					cardsToRemove.append(card)
		for card in cardsToRemove:
			deck.cards.erase(card)
	
	# Removes cards by tag
	if len(effectData.removeTag) > 0:
		var cardsToRemove = []
		for card in deck.cards:
			for searchTag in effectData.removeTag:
				for cardTag in Global.files[card].tags:
					if cardTag == searchTag:
						cardsToRemove.append(card)
		for card in cardsToRemove:
			deck.cards.erase(card)

# Returns true if there is an active event card on the board
func hasEventCard():
	return is_instance_valid(eventCardNode)

