extends Area2D



#if left click the deck sprite, runs action.
#In this case, when you click the deck, it will use the loadEvent fucntion from the Board.gd script
func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and not get_node("../Board").hasEventCard() \
	and event.button_index == BUTTON_LEFT \
	and event.is_pressed():
		print("Yes")
		get_node("../Board").loadEvent("test", false)

