extends Node

var current_scene = null
var files = {}
var startingDeck = []
var items = {}
var groups = {}
var tempGroupArray = []
var random = RandomNumberGenerator.new()


# Gets the current scene
func _ready():
	randomize()
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	#Files dictionary of the id : eventCard
	var dir = Directory.new()
	dir.open("res://eventCards/")
	dir.list_dir_begin()
	
	#Goes through everything in the eventCard directory
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			# Adds to a dictionary {'cardID : eventCardData'}
			var x = load("res://eventCards/" + file)
			
			var id = file.substr(0, file.length()-5)
			x.id = id
			
			# validates the card to ensure that all required fields are filled; if not, do not load it
			if !validate_card(file, x):
				continue
			
			# randomly adds club scouting card to start in deck
			if !x.tags.empty():
				if "club" in x.tags:
					random.randomize()
					if random.randi_range(0, 1) % 2 == 0:
						x.startInDeck = true
						print(x.id, " club is available this game.")
			
			# if card has startInDeck set to true, add to the starting deck
			files[str(x.id)] = x
			if x.startInDeck:
				startingDeck.append(str(x.id))
				

	dir.open("res://items/")
	dir.list_dir_begin()
	
	while true:
		var item = dir.get_next()
		if item == "":
			break
		elif not item.begins_with("."):
			items[str(load("res://items/" + item).id)] = load("res://items/" + item)
		
# Switches the active scene to the one given by the path
func goto_scene(path):
	call_deferred("_deferred_goto_scene", path)
	
# Switching the scene immediately would cause errors
# The switch is deferred until the current scene is ready to be deleted
func _deferred_goto_scene(path):
	current_scene.free()
	var s = ResourceLoader.load(path)
	current_scene = s.instance()
	get_tree().get_root().add_child(current_scene)
	get_tree().set_current_scene(current_scene)

# ensures that all required fields are present
func validate_card(filename, data):
	# check that the card has event text
	if data.eventText == "":
		print("EVENT CARD ERROR (" + filename + "): missing event text")
		return false
	
	# check that the card has a face
	if data.face == null:
		print("EVENT CARD ERROR (" + filename + "): missing face")
		return false
	
	# iterate through all options
	var counter = 0
	for option in data.options:
		# check that the option has flavor text
		if option.flavorText == null:
			print("OPTION CARD ERROR (" + filename + " option " + str(counter) + "): missing flavor text")
			return false
		
		# check that the option has a cost
		if option.cost == null:
			print("OPTION CARD ERROR (" + filename + " option " + str(counter) + "): missing cost")
			return false
		
		# check that the option has an effect
		if option.effectData == null:
			print("OPTION CARD ERROR (" + filename + " option " + str(counter) + "): missing effect")
			return false
			
		# check that the arrays for adding/removing resources are the same length
		if option.effectData.addResources.size() != option.effectData.numResources.size():
			print("OPTION CARD ERROR (" + filename + " option " + str(counter) + "): add resources array size mismatch")
			return false
		
		if option.effectData.removeResources.size() != option.effectData.numRemoveResources.size():
			print("OPTION CARD ERROR (" + filename + " option " + str(counter) + "): remove resources array size mismatch")
			return false
			
		# check that the arrays for adding guaranteed cards are the same length
		if option.effectData.guaranteeCardID.size() != option.effectData.numGuaranteeCardDraws.size():
			print("OPTION CARD ERROR (" + filename + " option " + str(counter) + "): guaranteed draw array size mismatch")
			return false
		counter += 1
	
	return true
