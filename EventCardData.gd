extends Resource
class_name EventCardData

# Event card id and identifying tags
export (String) var id = ""
export (Array, String) var tags = []

# Event card textures
export (Texture) var face = load("res://sprites/defaultFront.png")
export (Texture) var back = load("res://sprites/eventBack.png")

#Option cards
export (Array, Resource) var options = []
