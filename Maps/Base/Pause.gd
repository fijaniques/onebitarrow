extends Control

enum {MAIN, SCENESELECTION, RETRY, QUIT}

var selectionPos: int = 0
var sceneTo
var active: bool = false

func _ready():
	$Selection.global_position = $Selections.get_node("1").global_position
	_set_scene_to()


func _input(event):
	if Input.is_action_just_pressed("start"):
		selectionPos = 0
		$Selection.global_position = $Selections.get_child(selectionPos).global_position
		active = not active
		if active:
			AudioServer.set_bus_effect_enabled(0,0,true)
		else:
			AudioServer.set_bus_effect_enabled(0,0,false)
		var pauseState = not get_tree().paused
		get_tree().paused = pauseState
		visible = pauseState
	
	if active:
		if Input.is_action_just_pressed("s") and selectionPos < 3:
			MANAGER.get_node("Menu/Change").play()
			selectionPos += 1
			$Selection.global_position = $Selections.get_child(selectionPos).global_position
			_set_scene_to()
		elif Input.is_action_just_pressed("up") and selectionPos > 0:
			MANAGER.get_node("Menu/Change").play()
			selectionPos -= 1
			$Selection.global_position = $Selections.get_child(selectionPos).global_position
			_set_scene_to()
		
		if Input.is_action_just_pressed("jump"):
			if selectionPos != 3:
				if selectionPos == 2:
					AudioServer.set_bus_effect_enabled(0,0,false)
					MANAGER.get_node("Menu/Accept").play()
					get_tree().paused = false
					get_tree().current_scene.get_node("Colorizer/Character")._dying()
				else:
					AudioServer.set_bus_effect_enabled(0,0,false)
					for audio in MANAGER.get_node("Songs").get_child_count():
						MANAGER.get_node("Songs").get_child(audio).stop()
					MANAGER.get_node("Menu/Accept").play()
					MANAGER.get_node("Menu/Menu").play()
					MANAGER.playingMenu = true
					get_tree().change_scene(sceneTo)
					get_tree().paused = false
			else:
				get_tree().quit()


func _set_scene_to():
	match selectionPos:
		MAIN:
			sceneTo = "res://Menus/MainMenu/Menu.tscn"
		SCENESELECTION:
			sceneTo = "res://Menus/SceneMenu/SceneMenu.tscn"
		RETRY:
			sceneTo = null
		QUIT:
			sceneTo = null
