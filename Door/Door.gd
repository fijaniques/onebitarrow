extends Area2D

func _on_Door_body_entered(body):
	get_tree().current_scene.get_node("Colorizer").get_node("Character").visible = false
	_change_scene()


func _change_scene():
	if get_tree().current_scene.shooting:
		get_tree().current_scene.get_node("bInstance").queue_free()
	if MANAGER.stage == 20:
		MANAGER.ready21 = true
		get_tree().current_scene.get_node("FG").visible = true
	else:
		get_tree().current_scene._change_scene()
