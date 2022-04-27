extends Sprite

func _input(event):
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("back"):
		get_tree().change_scene("res://Menus/Options/Options.tscn")
