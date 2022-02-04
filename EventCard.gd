extends Area2D
class_name EventCard

# Whether the card is face up or not
export(bool) var faceUp = false

# The data that is used to generate the card
export(Resource) var cardData = null

# Array used for storing option card nodes
var optionCards = []

# True if the option cards have been spawned
var optionsRevealed = false

# Loads the data from resources by id - this needs to be called every time an EventCard is created
func setup(dataId, faceUp):
	self.faceUp = faceUp
	cardData = load("res://eventCards/" + dataId + ".tres")
	if faceUp:
		$Sprite.texture = cardData.face
	else:
		$Sprite.texture = cardData.back

# Flips the card over, changing its state and sprite
func flip():
	if faceUp:
		faceUp = false
		$Sprite.texture = cardData.back
	else:
		faceUp = true
		$Sprite.texture = cardData.face

# Spawns the option card nodes in the proper place and initializes them
func spawn_options():
	optionsRevealed = true
	self.position = Vector2(0, -220)
	var num = len(cardData.options)
	for option in num:
		var optionCardNode = load("res://OptionCard.tscn").instance()
		optionCardNode.setup(cardData.options[option], true)
		optionCardNode.name += " " + str(option)
		optionCards.append(optionCardNode)
		optionCardNode.position = Vector2(-(num-1)*80 + option*160, 0)
		get_node("../").add_child(optionCardNode)

# Called when the card is clicked
# If the card is face up and the option cards haven't been revealed yet, reveal them
# If the card is face down, flip it over
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if faceUp:
			if not optionsRevealed:
				spawn_options()
		else:
			flip()
