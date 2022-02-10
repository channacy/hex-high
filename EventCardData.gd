extends Resource
class_name EventCardData

# Event card id and identifying tags
export(String) var id = ""
export(Array, String) var tags = []

# Event card text
export(String) var eventText = ""

# Event card textures
export(Texture) var face = load("res://sprites/defaultFront.png")
var back = load("res://sprites/eventBack.jpg")

# If true, do not discard after drawn from the deck
export(bool) var infinite = false

# Option cards
export(Array, Resource) var options = []
