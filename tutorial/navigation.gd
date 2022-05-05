extends Button

#forward buttons on tutorial slides
func _on_forward_pressed():
	Global.goto_scene("res://tutorial/slide2.tscn")
	
func _on_forward2_pressed():
	Global.goto_scene("res://tutorial/slide3.tscn")

func _on_forward3_pressed():
	Global.goto_scene("res://tutorial/slide4.tscn")
	
func _on_forward4_pressed():
	Global.goto_scene("res://tutorial/slide5.tscn")
	
func _on_forward5_pressed():
	Global.goto_scene("res://tutorial/slide6.tscn")
	
func _on_forward6_pressed():
	Global.goto_scene("res://tutorial/slide7.tscn")
	
func _on_forward7_pressed():
	Global.goto_scene("res://tutorial/slide8.tscn")
	
func _on_forward8_pressed():
	Global.goto_scene("res://tutorial/slide9.tscn")
	
	
#back buttons on tutorial slides
func _on_back_pressed():
	Global.goto_scene("res://Menu.tscn")

func _on_back2_pressed():
	Global.goto_scene("res://tutorial/slide1.tscn")
	
func _on_back3_pressed():
	Global.goto_scene("res://tutorial/slide2.tscn")
	
func _on_back4_pressed():
	Global.goto_scene("res://tutorial/slide3.tscn")
	
func _on_back5_pressed():
	Global.goto_scene("res://tutorial/slide4.tscn")
	
func _on_back6_pressed():
	Global.goto_scene("res://tutorial/slide5.tscn")
	
func _on_back7_pressed():
	Global.goto_scene("res://tutorial/slide6.tscn")
	
func _on_back8_pressed():
	Global.goto_scene("res://tutorial/slide7.tscn")
	
func _on_back9_pressed():
	Global.goto_scene("res://tutorial/slide8.tscn")

func _on_skip_pressed():
	Global.goto_scene("res://Gameplay.tscn")

#home buttons on ending screens
func _on_HomeButton_pressed():
	Global.goto_scene("res://Menu.tscn")

func _on_Button_pressed():
	Global.goto_scene("res://tutorial/GoodEnding1.tscn")

