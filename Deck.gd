extends Area2D

var board = null
var counter = null
var count = null
var cardInsert = null
var arrOfInsertions = {}
var insertKeys = []
# array of event cards from folder called eventCards
var cards = ["potionShop0", "witchShop0", "scenario0", "sleep", "study", "tuition", "shopping", "alchemyExam", "artificeExam", "sorceryExam", "summoningExam", "scenario1", "scenario2", "scenario3", "scenario4", "scenario5", "scenario6", "scenario7", "break", "freeTime"]
var randomNum = RandomNumberGenerator.new()
var myRandomNum = 0

# Object for tracking conditional cards that should only exist if the player has certain resources
var resourceConditionals = {}

# Finds the board in the hierarchy and saves it for later use
func _ready():
	counter = 0
	randomNum.randomize()
	board = get_node("../../Board")
	addGuaranteed(5, "potionShop0")
	addGuaranteed(10, "potionShop0")
	addGuaranteed(15, "potionShop0")

# If left click the deck sprite, runs action.
# In this case, when you click the deck, it will use the loadEvent fucntion from the Board.gd script
func _input_event(viewport, event, shape_idx):
	
	if event is InputEventMouseButton \
	and not board.hasEventCard() \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		print(cards)
		counter += 1
		print(counter)
		var didDraw = false
		if !insertKeys.empty():
			for i in insertKeys:
				if i == counter:
					board.loadEvent(arrOfInsertions.get(i), false)
					print("Card Inserted:",arrOfInsertions.get(i))
					didDraw = true
					insertKeys.erase(i)
					arrOfInsertions.erase(i)
		if !didDraw: 
			myRandomNum = randomNum.randf_range(0, cards.size())
			var cardId = cards[myRandomNum]
			#adds resources based on event cards
			# Removes the drawn card from the deck if it isn't marked as infinite
			if !Global.files[cardId].infinite:
				cards.remove(myRandomNum)
				print(cardId, "removed from deck")
				
			print("Normal Random Draw:", cardId)
			board.loadEvent(cardId, false)

# Adds a card to the list of guaranteed draws
func addGuaranteed(numDraws, cardID):
	count = counter + numDraws
	# Handles cards being inserted at the same counter index as a guaranteed card that already exists
	# The card being inserted is pushed back to the next available index
	while insertKeys.find(count, 0) != -1:
		count += 1
	arrOfInsertions[count] = cardID
	insertKeys.append(count)
	
# Removes a card from the list of guaranteed draws
func removeGuaranteed(cardID):
	for i in insertKeys:
		if arrOfInsertions[i] == cardID:
			insertKeys.remove(i)
			arrOfInsertions[i] = null
			i -= 1
