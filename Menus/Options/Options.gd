extends Control

var markerPos: int = 0
var toScene
enum {CONTROLS, VOLUME, BACK}


func _ready():
	_set_marker_position()


func _input(event):
	if Input.is_action_just_pressed("s") and markerPos < 2:
		MANAGER.get_node("Menu/Change").play()
		markerPos += 1
	elif Input.is_action_just_pressed("up") and markerPos > 0:
		MANAGER.get_node("Menu/Change").play()
		markerPos -= 1
	
	_set_marker_position()
	
	if Input.is_action_just_pressed("jump"):
		MANAGER.get_node("Menu/Accept").play()
		get_tree().change_scene(toScene)
	elif Input.is_action_just_pressed("back"):
		MANAGER.get_node("Menu/Back").play()
		get_tree().change_scene("res://Menus/MainMenu/Menu.tscn")


func _set_marker_position():
	match markerPos:
		CONTROLS:
			$Marker.position = $Positions/Controls.position
			toScene = "res://Menus/Controls/Controls.tscn"
		VOLUME:
			$Marker.position = $Positions/Volume.position
			toScene = "res://Menus/AudioControl/AudioControl.tscn"
		BACK:
			$Marker.position = $Positions/Back.position
			toScene = "res://Menus/MainMenu/Menu.tscn"
