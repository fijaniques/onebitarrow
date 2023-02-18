extends Control

onready var volume = AudioServer.get_bus_index("Master")
var pressed: bool = false
var holding: bool = false
var defaultValue: float = 5
var dir: int = 0

func _ready():
	AudioServer.set_bus_volume_db(volume, MANAGER.volume)
	$HSlider.value = MANAGER.volume


func _process(delta):
	if holding:
		$HSlider.value += dir


func _input(event):
	if Input.is_action_just_pressed("back") or Input.is_action_just_pressed("jump"):
		_to_menu()
	elif Input.is_action_just_pressed("d") and !pressed:
		MANAGER.get_node("Menu/Change").play()
		pressed = true
		dir = 1
		$Holder.start()
		$HSlider.value += defaultValue
	elif Input.is_action_just_pressed("a") and !pressed:
		MANAGER.get_node("Menu/Change").play()
		pressed = true
		dir = -1
		$Holder.start()
		$HSlider.value -= defaultValue
	
	if Input.is_action_just_released("a") or Input.is_action_just_released("d"):
		pressed = false
		holding = false
		dir = 0
	
	MANAGER.volume = $HSlider.value


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(volume, value)


func _to_menu():
	MANAGER.get_node("Menu/Accept").play()
	get_tree().change_scene("res://Menus/MainMenu/Menu.tscn")


func _on_Button_pressed():
	_to_menu()


func _on_Holder_timeout():
	holding = true
