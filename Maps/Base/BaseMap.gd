extends Control

onready var trap = $Colorizer/Traps
onready var act = $Colorizer/Activatable
var bullet = preload("res://Bullet/Bullet.tscn")

var shooting: bool = false
var bInstance

func _ready():
	_start_scene()
	$Colorizer/Character.connect("the_bullet", self, "_shoot")
	$Colorizer/Character.connect("teleport", self, "_teleport")
	_change_color()


func _shoot(dShot):
	bInstance = bullet.instance()
	bInstance.dir = dShot
	if dShot.y > 0:
		bInstance.global_position = $Colorizer/Character/DownGun.global_position
	elif dShot.y < 0:
		bInstance.global_position = $Colorizer/Character/UpGun.global_position
	else:
		bInstance.global_position = $Colorizer/Character/Gun.global_position
	if dShot.x < 0:
		bInstance.flipped = true
	$Colorizer.add_child(bInstance)


func _teleport():
	$Colorizer/Character.position = bInstance.position
	$Colorizer/Character.velocity.y = 0
	bInstance.queue_free()


func _change_scene():
	var a = name.replace("Map", "")
	var b = int(a)
	var nextScene
	if MANAGER.stage < 9:
		nextScene = str("res://Maps/Map0", b +1, "/Map0", b +1, ".tscn")
	else:
		nextScene = str("res://Maps/Map", b +1, "/Map", b +1, ".tscn")
	_change_color()
	get_tree().change_scene(nextScene)


func _change_color():
	if MANAGER.stage >= 6:
		$Colorizer.modulate = Color("28b642") #VERDE
		if MANAGER.stage >= 11:
			$Colorizer.modulate = Color("009dc7") #AZUL
			if MANAGER.stage >= 16:
				$Colorizer.modulate = Color("cf72c9") #ROSA
				if MANAGER.stage >= 21:
					$Colorizer.modulate = Color("d02b2b") #VERMELHO
	else:
		$Colorizer.modulate = Color("996600") #MARROM/LARANJA


func _start_scene():
	var a = name.replace("Map", "")
	var b = int(a)
	MANAGER.stage = b
	MANAGER._play()
