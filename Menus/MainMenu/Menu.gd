extends Control

var markerPos: int = 0
var toScene
enum {PLAY, OPTIONS, EXIT}


func _ready():
	MANAGER.onStage = false
	MANAGER.get_node("Songs/World5").stop()
	_set_marker_position()


func _process(delta):
	MANAGER.get_node("Songs/World5Pos").stop()


func _input(event):
	if Input.is_action_just_pressed("s") and markerPos < 2:
		MANAGER.get_node("Menu/Change").play()
		markerPos += 1
	elif Input.is_action_just_pressed("up") and markerPos > 0:
		MANAGER.get_node("Menu/Change").play()
		markerPos -= 1
	
	_set_marker_position()
	
	if Input.is_action_just_pressed("jump"):
		if markerPos == 2:
			get_tree().quit()
		else:
			MANAGER.get_node("Menu/Accept").play()
			_change_scene()


func _set_marker_position():
	match markerPos:
		PLAY:
			$Marker.position = $Positions/Play.position
			toScene = "res://Menus/SceneMenu/SceneMenu.tscn"
		OPTIONS:
			$Marker.position = $Positions/Options.position
			toScene = "res://Menus/Options/Options.tscn"
		EXIT:
			$Marker.position = $Positions/Exit.position


func _on_LinkButton_pressed():
	MANAGER.get_node("Menu/Accept").play()
	OS.shell_open("https://sites.google.com/view/linasgames")


func _change_scene():
	get_tree().change_scene(toScene)
