extends Area2D

var board = null
var counter = null
var arrOfInsertions = {}
var insertKeys = []
# array of event cards from folder called eventCards
var cards = []
var randomNum = RandomNumberGenerator.new()
var myRandomNum = 0

# Object for tracking conditional cards that should only exist if the player has certain resources
var resourceConditionals = {}

# Finds the board in the hierarchy and saves it for later use
func _ready():
	cards = Global.startingDeck
	counter = 0
	#Random Number Generator
	randomNum.randomize()
	board = get_node("../../Board")
	addGuaranteed(1, "devCardResources")
	addGuaranteed(1, "finalExam")
	addGuaranteed(1, "magicTheoryClub1")

# If left click the deck sprite, runs action.
# In this case, when you click the deck, it will use the loadEvent fucntion from the Board.gd script
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and not board.hasEventCard() and event.button_index == BUTTON_LEFT and event.is_pressed():
		counter += 1
		print(counter, " cards drawn so far...")
		var didDraw = false
		if !insertKeys.empty():
			for i in insertKeys:
				if i == counter:
					board.loadEvent(arrOfInsertions.get(i), false, true)
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
				print(cardId, " removed from the deck")
				print(len(cards), " amount of cards in the deck remaining.")
				
			print("Normal Random Draw:", cardId)
			board.loadEvent(cardId, false, true)

# Adds a card to the list of guaranteed draws
func addGuaranteed(numDraws, cardID):
	var count = counter + numDraws
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
