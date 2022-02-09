extends Area2D

var board = null

# Finds the board in the hierarchy and saves it for later use
func _ready():
	board = get_node("../../Board")

# If left click the deck sprite, runs action.
# In this case, when you click the deck, it will use the loadEvent fucntion from the Board.gd script
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and not board.hasEventCard() \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		print("Yes")
		board.loadEvent("test", false)

