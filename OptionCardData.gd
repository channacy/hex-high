extends Resource
class_name OptionCardData

var face = load("res://sprites/optionFront.png")
var back = load("res://sprites/optionBack.jpg")

# Action description
export(String) var flavorText = ""

# Detailed effect description
export(String) var effectText = ""

# Displays which resources are needed to use card
export(String) var costText = ""
export(Resource) var cost = null

# Effect data
export(Resource) var effectData = null
