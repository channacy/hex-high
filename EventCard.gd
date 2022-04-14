extends Area2D
class_name EventCard

# Whether the card is face up or not
export(bool) var faceUp = false

# Whether the card is in the hand or not
export(bool) var inHand = false

# The data that is used to generate the card
export(Resource) var cardData = null

# Array used for storing option card nodes
var optionCards = []

# True if the option cards have been spawned
var optionsRevealed = false

# Loads the data from resources by id - this needs to be called every time an EventCard is created
func setup(dataId, faceUp):
	self.faceUp = faceUp
	cardData = Global.files[dataId]
	#load("res://eventCards/" + dataId + ".tres")
	if faceUp:
		$Sprite.texture = cardData.face
		$EventContainer/EventText.bbcode_text = "[center][color=black]" + cardData.eventText + "[/color][/center]"
	else:
		$Sprite.texture = cardData.back
		$EventContainer/EventText.bbcode_text = ""
		
	$FlipFirstHalf.interpolate_property(self, "scale",
		Vector2(1, 1), Vector2(0, 1), 0.3,
		Tween.TRANS_CUBIC, Tween.EASE_IN)
	$FlipSwapFace.interpolate_callback(self, 0.3, "swap_face")
	$FlipSecondHalf.interpolate_property(self, "scale",
		Vector2(0, 1), Vector2(1, 1), 0.3,
		Tween.TRANS_CUBIC, Tween.EASE_OUT)

# Flips the card over, changing its state and sprite
func flip():
	$FlipFirstHalf.start()
	$FlipSwapFace.start()

# Changes the sprite on the card
func swap_face():
	$FlipSecondHalf.start()
	if faceUp:
		faceUp = false
		$Sprite.texture = cardData.back
		$EventContainer/EventText.bbcode_text = ""
	else:
		faceUp = true
		$Sprite.texture = cardData.face
		$EventContainer/EventText.bbcode_text = "[center][color=black]" + cardData.eventText + "[/color][/center]"

# Spawns the option card nodes in the proper place and initializes them
func spawn_options():
	optionsRevealed = true
	self.position = Vector2(0, -220)
	var num = len(cardData.options)
	for option in num:
		var optionCardNode = load("res://OptionCard.tscn").instance()
		optionCardNode.setup(cardData.options[option], false)
		optionCardNode.name += " " + str(option)
		optionCards.append(optionCardNode)
		optionCardNode.position = Vector2(-(num-1)*80 + option*160, 0)
		get_node("../").add_child(optionCardNode)
		$SpawnOptions.interpolate_callback(optionCardNode, option*0.1, "flip")
		$SpawnOptions.start()

# Called when the card is clicked
# If the card is face up and the option cards haven't been revealed yet, reveal them
# If the card is face down, flip it over
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed:
		if faceUp:
			if inHand:
				if not get_node("../../Board").hasEventCard() and get_node("../").highlighted == self.z_index:
					get_node("../../Board").loadEvent(cardData.id, true)
					self.queue_free()
					get_node("../").removeCard(self)
			elif not optionsRevealed:
				spawn_options()
		else:
			flip()
	elif inHand and event is InputEventMouse:
		if get_node("../").highlighted < self.z_index:
			get_node("../").highlighted = self.z_index

# Resets the highlight if the mouse moves off of this card and it was highlighted
func _on_EventCard_mouse_exited():
	if inHand and get_node("../").highlighted == self.z_index:
			get_node("../").highlighted = 0
			
		
