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

# Returns true if there is an active event card on the board
func hasEventCard():
	return is_instance_valid(eventCardNode)

