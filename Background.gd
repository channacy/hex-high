extends Control
export(Texture) var texture = null


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/Sprite.texture = texture 


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Background_resized():
	var bg = float($Control/Sprite.texture.get_height() )/ $Control/Sprite.texture.get_width()
	var screen = get_viewport().size.y / get_viewport().size.x
	if bg < screen:
		$Control/Sprite.scale.y = get_viewport().size.y / $Control/Sprite.texture.get_height()
		$Control/Sprite.scale.x = (get_viewport().size.y / bg) / $Control/Sprite.texture.get_width()
	if bg > screen:
		$Control/Sprite.scale.y = (get_viewport().size.x * bg) / $Control/Sprite.texture.get_height()
		$Control/Sprite.scale.x = get_viewport().size.x / $Control/Sprite.texture.get_width()
	pass # Replace with function body.


func _on_skip_pressed():
	pass # Replace with function body.
