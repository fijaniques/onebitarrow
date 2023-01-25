extends Area2D

func _on_Door_body_entered(body):
	_change_scene()


func _change_scene():
	get_tree().current_scene.get_node("Colorizer").get_node("Character").visible = false
	if get_tree().current_scene.shooting:
		get_tree().current_scene.get_node("bInstance").queue_free()
	get_tree().current_scene._change_scene()
