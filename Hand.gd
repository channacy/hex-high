extends Control

# The event cards currently in the hand
var eventCardNodes = []

# Called when the node enters the scene tree for the first time.
func _ready():
	addCard("test")
	pass # Replace with function body.

func addCard(id):
	var eventCardNode = load("res://EventCard.tscn").instance()
	eventCardNode.setup(id, true)
	eventCardNode.inHand = true
	eventCardNodes.append(eventCardNode)
	add_child(eventCardNode)
	updateHand()

func updateHand():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
