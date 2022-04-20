extends Control

onready var trap = $Colorizer/Traps
onready var act = $Colorizer/Activatable
var bullet = preload("res://Bullet/Bullet.tscn")

var shooting: bool = false
var bInstance

var collectible: bool = false
var haveCoins: bool = false
export var unlocked: bool = false

func _ready():
	_get_world()
	_start_scene()
	$Colorizer/Character.connect("the_bullet", self, "_shoot")
	$Colorizer/Character.connect("teleport", self, "_teleport")
	_change_color()


func _input(event):
	if Input.is_action_just_pressed("forward"):
		_change_scene()
	elif Input.is_action_just_pressed("to_menu"):
		get_tree().change_scene("res://Menus/SceneMenu/SceneMenu.tscn")


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


func _get_world():
	var a = str(filename)
	var b = a.replace("res://Maps/World0", "")
	MANAGER.world = int(b[0])


func _change_scene():
	var a = int(name.replace("Map", ""))
	MANAGER.stage = a
	if collectible:
		MANAGER.collectible += 1
		if MANAGER.world == 1:
			MANAGER.c1.append("collectible")
			if MANAGER.c1.size() == 5:
				haveCoins = true
		elif MANAGER.world == 2:
			MANAGER.c2.append("collectible")
			if MANAGER.c2.size() == 5:
				haveCoins = true
		elif MANAGER.world == 3:
			MANAGER.c3.append("collectible")
			if MANAGER.c3.size() == 5:
				haveCoins = true
		elif MANAGER.world == 4:
			MANAGER.c4.append("collectible")
			if MANAGER.c4.size() == 5:
				haveCoins = true
		elif MANAGER.world == 5:
			MANAGER.c5.append("collectible")
			if MANAGER.c5.size() == 5:
				haveCoins = true
		elif MANAGER.world == 6:
			MANAGER.c6.append("collectible")
			if MANAGER.c6.size() == 5:
				haveCoins = true
	var nextScene
	if haveCoins or MANAGER.stage < 5:
		nextScene = str("res://Maps/World0", MANAGER.world, "/Map0", a +1, "/Map0", a +1, ".tscn")
	else:
		nextScene = str("res://Maps/World0", MANAGER.world + 1, "/Map01/Map01.tscn")
		MANAGER.world += 1
		MANAGER.playing = false
	
	get_tree().change_scene(nextScene)
	_change_color()


func _change_color():
	if MANAGER.world >= 2:
		$Colorizer.modulate = Color("28b642") #VERDE
		if MANAGER.world >= 3:
			$Colorizer.modulate = Color("009dc7") #AZUL
			if MANAGER.world >= 4:
				$Colorizer.modulate = Color("cf72c9") #ROSA
				if MANAGER.world >= 5:
					$Colorizer.modulate = Color("d02b2b") #VERMELHO
					if MANAGER.world >= 6:
						$Colorizer.modulate = Color(0,0,0) #PRETO
	else:
		$Colorizer.modulate = Color("996600") #MARROM/LARANJA


func _start_scene():
	var a = name.replace("Map0", "")
	var b = int(a)
	MANAGER.stage = b
	MANAGER._play()
