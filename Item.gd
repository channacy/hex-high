extends Area2D
class_name Item


#creates inventory object
func setup(item, numOfItems):
	$Sprite.texture = item.itemImg
	$NumberContainer/Number.bbcode_text = str(numOfItems)
	

