extends Area2D

func _on_Door_body_entered(body):
	_change_scene()


func _change_scene():
	get_tree().current_scene.get_node("Colorizer").get_node("Character").visible = false
	if get_tree().current_scene.shooting:
		get_tree().current_scene.get_node("bInstance").queue_free()
#	if MANAGER.stage == 20:
#		MANAGER.ready21 = true
#		get_tree().current_scene.get_node("FG").visible = true
#	elif MANAGER.stage == 25:
#			MANAGER.ready26 = true
#	elif MANAGER.stage == 27:
#		MANAGER.get_node("Final").stop()
#		get_tree().current_scene._change_scene()
#	elif MANAGER.stage == 24:
#		MANAGER.get_node("HardTheme").stop()
#		get_tree().current_scene._change_scene()
#	else:
#		get_tree().current_scene._change_scene()
	get_tree().current_scene._change_scene()
