extends Control

enum {CONTINUE, MAIN, SCENESELECTION, RETRY, QUIT}

var selectionPos: int = 0
var sceneTo
var active: bool = false

func _ready():
	$Selection.global_position = $Selections.get_node("1").global_position
	_set_scene_to()


func _input(event):
	if Input.is_action_just_pressed("start"):
		print("Apertou start")
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
		if Input.is_action_just_pressed("back"):
			selectionPos = 0
			$Selection.global_position = $Selections.get_child(selectionPos).global_position
			active = false
			AudioServer.set_bus_effect_enabled(0,0,false)
			get_tree().paused = false
			visible = false
			
		if Input.is_action_just_pressed("s") and selectionPos < 4:
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
			_change_scene()


func _set_scene_to():
	match selectionPos:
		CONTINUE:
			sceneTo = null
		MAIN:
			sceneTo = "res://Menus/MainMenu/Menu.tscn"
		SCENESELECTION:
			sceneTo = "res://Menus/SceneMenu/SceneMenu.tscn"
		RETRY:
			sceneTo = null
		QUIT:
			sceneTo = null


func _change_scene():
	if selectionPos != 4:
		if selectionPos == 3:
			AudioServer.set_bus_effect_enabled(0,0,false)
			MANAGER.get_node("Menu/Accept").play()
			get_tree().paused = false
			get_tree().current_scene.get_node("Colorizer/Character")._dying()
		elif selectionPos == 0:
			active = false
			AudioServer.set_bus_effect_enabled(0,0,false)
			var pauseState = false
			get_tree().paused = pauseState
			visible = pauseState
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
