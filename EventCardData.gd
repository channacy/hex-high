extends Resource
class_name EventCardData

# Event card id and identifying tags
var id = ""
export(Array, String) var tags = []

# Event card text
export(String) var eventText = ""

# Event card textures
export(Texture) var face = load("res://sprites/defaultFront.png")
var back = load("res://sprites/eventBack.jpg")

# If true, do not discard after drawn from the deck
export(bool) var infinite = false

# If true, will be an available card in the deck at the start of the game
export(bool) var startInDeck = false

# Option cards
export(Array, Resource) var options = []

