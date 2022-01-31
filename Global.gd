extends Node

var current_scene = null

# Gets the current scene
func _ready():
	var root = get_tree().get_root()
	current_scene = root.get_child(root.get_child_count() - 1)
	
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
