extends Control

onready var volume = AudioServer.get_bus_index("Master")

func _ready():
	AudioServer.set_bus_volume_db(volume, MANAGER.volume)
	$HSlider.value = MANAGER.volume


func _input(event):
	if Input.is_action_just_pressed("back") or Input.is_action_just_pressed("jump"):
		_to_menu()
	elif Input.is_action_just_pressed("d"):
		MANAGER.get_node("Menu/Change").play()
		$HSlider.value += 5
	elif Input.is_action_just_pressed("a"):
		MANAGER.get_node("Menu/Change").play()
		$HSlider.value -= 5
	
	MANAGER.volume = $HSlider.value


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(volume, value)


func _to_menu():
	MANAGER.get_node("Menu/Accept").play()
	get_tree().change_scene("res://Menus/MainMenu/Menu.tscn")


func _on_Button_pressed():
	_to_menu()
