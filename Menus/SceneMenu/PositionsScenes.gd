extends Node2D

func _on_1_pressed():
	get_tree().current_scene._change_scene()


func _on_1_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.selected = 1
	get_tree().current_scene._get_selection()


func _on_2_pressed():
	get_tree().current_scene._change_scene()


func _on_2_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.selected = 2
	get_tree().current_scene._get_selection()


func _on_3_pressed():
	get_tree().current_scene._change_scene()


func _on_3_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.selected = 3
	get_tree().current_scene._get_selection()


func _on_4_pressed():
	get_tree().current_scene._change_scene()


func _on_4_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.selected = 4
	get_tree().current_scene._get_selection()


func _on_5_pressed():
	get_tree().current_scene._change_scene()


func _on_5_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.selected = 5
	get_tree().current_scene._get_selection()


func _on_6_pressed():
	get_tree().current_scene._change_scene()


func _on_6_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.selected = 6
	get_tree().current_scene._get_selection()
