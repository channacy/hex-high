extends Button
export(String) var path = ""


func _on_nav_pressed():
	Global.goto_scene(path)
