extends Node2D


func _on_1_pressed():
	get_tree().current_scene.get_node("Pause")._change_scene()


func _on_1_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.get_node("Pause").selectionPos = 0
	get_tree().current_scene.get_node("Pause/Selection").global_position = get_tree().current_scene.get_node("Pause/Selections/1").global_position
	get_tree().current_scene.get_node("Pause")._set_scene_to()


func _on_2_pressed():
	get_tree().current_scene.get_node("Pause")._change_scene()


func _on_2_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.get_node("Pause").selectionPos = 1
	get_tree().current_scene.get_node("Pause/Selection").global_position = get_tree().current_scene.get_node("Pause/Selections/2").global_position
	get_tree().current_scene.get_node("Pause")._set_scene_to()


func _on_3_pressed():
	get_tree().current_scene.get_node("Pause")._change_scene()


func _on_3_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.get_node("Pause").selectionPos = 2
	get_tree().current_scene.get_node("Pause/Selection").global_position = get_tree().current_scene.get_node("Pause/Selections/3").global_position
	get_tree().current_scene.get_node("Pause")._set_scene_to()


func _on_4_pressed():
	get_tree().current_scene.get_node("Pause")._change_scene()


func _on_4_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.get_node("Pause").selectionPos = 3
	get_tree().current_scene.get_node("Pause/Selection").global_position = get_tree().current_scene.get_node("Pause/Selections/4").global_position
	get_tree().current_scene.get_node("Pause")._set_scene_to()


func _on_5_pressed():
	get_tree().current_scene.get_node("Pause")._change_scene()


func _on_5_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.get_node("Pause").selectionPos = 4
	get_tree().current_scene.get_node("Pause/Selection").global_position = get_tree().current_scene.get_node("Pause/Selections/4").global_position
	get_tree().current_scene.get_node("Pause")._set_scene_to()
