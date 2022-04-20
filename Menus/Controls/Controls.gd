extends Sprite

func _input(event):
	if Input.is_action_just_pressed("jump") or Input.is_action_just_pressed("start"):
		get_tree().change_scene("res://Maps/World01/Map01/Map01.tscn")
