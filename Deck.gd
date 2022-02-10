extends Area2D

var board = null
# array of event cards from folder called eventCards
var cards = ["potionShop0", "potionShop1", "Scenario0","sleep", "study", "tuition", "shopping", "exam0","exam1","exam2","exam3","Scenario1","Scenario2","Scenario3","Scenario4","Scenario5","Scenario6","Scenario7","break","freeTime"]
var randomNum = RandomNumberGenerator.new()
var myRandomNum = 0 

# Finds the board in the hierarchy and saves it for later use
func _ready():
	randomNum.randomize()
	board = get_node("../../Board")

# If left click the deck sprite, runs action.
# In this case, when you click the deck, it will use the loadEvent fucntion from the Board.gd script
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and not board.hasEventCard() \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		myRandomNum = randomNum.randf_range(0, cards.size())
		var cardId = cards[myRandomNum]
		print("Yes")
		print(cardId)
		board.loadEvent(cardId, false)

		
		

