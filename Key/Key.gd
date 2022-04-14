extends Area2D


func _on_Key_body_entered(body):
	get_tree().current_scene.get_node("Colorizer").get_node("Door").haveKey = true
	get_tree().current_scene.get_node("Colorizer").get_node("Door")._open_door()
	queue_free()
