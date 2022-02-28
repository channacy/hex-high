extends Area2D
class_name Item

# Called when the node enters the scene tree for the first time.
func setup(item, numOfItems):
	$Sprite.texture = item.itemImg
	$NumberContainer/Number.bbcode_text = str(numOfItems)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
