extends Control

func _on_Timer_timeout():
	MANAGER.get_node("Menu/Menu").play()
	get_tree().change_scene("res://Menus/AudioControl/AudioControl.tscn")
