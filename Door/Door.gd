extends Area2D

func _on_Door_body_entered(body):
	$Door.play()
	$AnimationPlayer.play("Next")
	get_tree().current_scene.get_node("Character").visible = false


func _change_scene():
	if get_tree().current_scene.shooting:
		get_tree().current_scene.get_node("bInstance").queue_free()
	get_tree().current_scene._change_scene()
