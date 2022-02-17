extends Node

var current_scene = null
var files = {}


# Gets the current scene
func _ready():
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
			files[str(load("res://eventCards/" + file).id)] = load("res://eventCards/" + file)

	
	print(files)
	
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
