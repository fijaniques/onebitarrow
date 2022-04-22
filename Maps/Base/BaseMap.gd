extends Control

onready var trap = $Colorizer/Traps
onready var act = $Colorizer/Activatable
var bullet = preload("res://Bullet/Bullet.tscn")

var shooting: bool = false
var bInstance

var pickedCollectible: bool = false
var haveCoins: bool = false
#export var unlocked: bool = false
export var lastStage: bool = false

func _ready():
	_get_world()
	_start_scene()
	$Colorizer/Character.connect("the_bullet", self, "_shoot")
	$Colorizer/Character.connect("teleport", self, "_teleport")
	_change_color()


func _input(event):
	if Input.is_action_just_pressed("forward"):
		$Colorizer/Collectible._picked()
		_change_scene()
	elif Input.is_action_just_pressed("start"):
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
	
	if pickedCollectible:
		MANAGER.collectible += 1
		MANAGER.coins[MANAGER.world -1].append("coin")
		if MANAGER.coins[MANAGER.world -1].size() == 5:
			haveCoins = true
	var nextScene
	if !lastStage:
		if haveCoins or MANAGER.stage < 5:
			nextScene = str("res://Maps/World0", MANAGER.world, "/Map0", a +1, "/Map0", a +1, ".tscn")
		else:
			nextScene = str("res://Maps/World0", MANAGER.world + 1, "/Map01/Map01.tscn")
			MANAGER.world += 1
			MANAGER.playing = false
	else:
		nextScene = "res://Maps/End/End.tscn"
		for audio in MANAGER.get_node("Songs").get_child_count():
			MANAGER.get_node("Songs").get_child(audio).stop()
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
	if name != "End":
		MANAGER.stage = int(name.replace("Map0", ""))
	if !MANAGER.playing:
		MANAGER._play()
		MANAGER.playing = true
	MANAGER.reached[MANAGER.world -1][MANAGER.stage -1] = 1
