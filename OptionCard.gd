extends Area2D
class_name OptionCard

# Whether the card is face up or not
export(bool) var faceUp = false

# The data that is used to generate the card
export(Resource) var optionData = null

# Loads the data from resources by id - this needs to be called every time an OptionCard is created
func setup(data, faceUp):
	self.faceUp = faceUp
	optionData = data
	if faceUp:
		$Sprite.texture = optionData.face
		$FlavorContainer/FlavorText.bbcode_text = "[center][color=black]" + optionData.flavorText + "[/color][/center]"
		$EffectContainer/EffectText.bbcode_text = "[center][color=black]" + optionData.effectText + "[/color][/center]"
		$CostContainer/CostText.bbcode_text = "[center][color=black]" + optionData.costText + "[/color][/center]"
	else:
		$Sprite.texture = optionData.back
		$FlavorContainer/FlavorText.bbcode_text = ""
		$EffectContainer/EffectText.bbcode_text = ""
		$CostContainer/CostText.bbcode_text = ""

# Flips the card over, changing its state, sprite, and text
func flip():
	if faceUp:
		faceUp = false
		$Sprite.texture = optionData.back
		$FlavorContainer/FlavorText.bbcode_text = ""
		$EffectContainer/EffectText.bbcode_text = ""
		$CostContainer/CostText.bbcode_text = ""
	else:
		faceUp = true
		$Sprite.texture = optionData.face
		$FlavorContainer/FlavorText.bbcode_text = "[center][color=black]" + optionData.flavorText + "[/color][/center]"
		$EffectContainer/EffectText.bbcode_text = "[center][color=black]" + optionData.effectText + "[/color][/center]"
		$CostContainer/CostText.bbcode_text = "[center][color=black]" + optionData.costText + "[/color][/center]"

			
# Called when the option card isclicked
# If the option card is face up, execute its effect

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.pressed and faceUp:
		if is_instance_valid(optionData.cost):
			if get_node("../").checkCost(optionData.cost) == true:
				print("can use")
				get_node("../").execute(optionData.effectData)
		else:
			print("test")
			get_node("../").execute(optionData.effectData)
	else:
		return
			
			

