extends Node2D

func _on_Play_pressed():
	_change_scene()


func _on_Play_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.markerPos = 0
	get_tree().current_scene._set_marker_position()

func _on_Options_pressed():
	_change_scene()


func _on_Options_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.markerPos = 1
	get_tree().current_scene._set_marker_position()


func _on_Exit_pressed():
	get_tree().quit()


func _on_Exit_mouse_entered():
	MANAGER.get_node("Menu/Change").play()
	get_tree().current_scene.markerPos = 2
	get_tree().current_scene._set_marker_position()


func _change_scene():
	MANAGER.get_node("Menu/Accept").play()
	get_tree().current_scene._change_scene()


func _on_LinkButton2_pressed():
	get_tree().change_scene("res://Menus/Credits/Credits.tscn")
