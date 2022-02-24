extends Area2D
class_name Item

export(Resource) var itemData = null

# Called when the node enters the scene tree for the first time.
func setup(item, numOfItems):
	itemData = item
	$Sprite.texture = itemData.face
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
