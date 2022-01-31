extends Node
class_name EventCard

# Whether the card is face up or not
export (bool) var faceUp = false

# The data that is used to generate the card
export (Resource) var cardData = null

# Loads the data from resources by id - this needs to be called every time an EventCard is created
func setup(dataId):
	cardData = load("res://eventCards/" + dataId + ".tres")

# Called when the node enters the scene tree for the first time
func _ready():
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
