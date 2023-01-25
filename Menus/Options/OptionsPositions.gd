extends Node2D

func _on_Controls_pressed():
	_accept()


func _on_Controls_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.markerPos = 0
	get_tree().current_scene._set_marker_position()


func _on_Volume_pressed():
	_accept()


func _on_Volume_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.markerPos = 1
	get_tree().current_scene._set_marker_position()


func _accept():
	MANAGER.get_node("Menu/Accept").play()
	get_tree().current_scene._change_scene()
