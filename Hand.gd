extends Control

# The event cards currently in the hand
var eventCardNodes = []

# The currently highlighted card by index
var highlighted = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	addCard("test")
	pass # Replace with function body.

# Adds a card to the hand
func addCard(id):
	var eventCardNode = load("res://EventCard.tscn").instance()
	eventCardNode.setup(id, true)
	eventCardNode.inHand = true
	eventCardNodes.append(eventCardNode)
	add_child(eventCardNode)
	updateHand()

# Removes a card from the hand
func removeCard(node):
	eventCardNodes.erase(node)
	highlighted = 0
	updateHand()

# Updates the positions of the card in the hand
func updateHand():
	var num = len(eventCardNodes)
	for card in num:
		var angle = deg2rad(-(num-1)*10 + card * 20)
		if num > 5:
			angle = deg2rad(-(num-1)*(50.0/num) + card * (100.0/num))
		
		eventCardNodes[card].position = Vector2(sin(angle)*240, -cos(angle)*240 + 160)
		eventCardNodes[card].rotation = angle
		eventCardNodes[card].z_index = card

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
