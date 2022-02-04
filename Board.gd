extends Control

# The currently active event card node
var eventCardNode = null

# Called when the node enters the scene tree for the first time.
func _ready():
	loadEvent("test", false)
	print_tree()

# Creates an event card node and initializes it
func loadEvent(eventCardId, faceUp):
	if not eventCardNode == null:
		eventCardNode.queue_free()
	eventCardNode = load("res://EventCard.tscn").instance()
	eventCardNode.setup(eventCardId, faceUp)
	add_child(eventCardNode)

# Executes the effect of the option card selected and clears the board for the next event
func execute(effectData):
	for optionCardNode in eventCardNode.optionCards:
		optionCardNode.queue_free()
	eventCardNode.queue_free()
	
	# Since the deck and hand are not implemented yet, this function cannot be fully implemented
	# Instead, it just loads the test event card again
	loadEvent("test", false)
