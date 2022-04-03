extends Control

onready var trap = $Traps
var bullet = preload("res://Bullet/Bullet.tscn")

var shooting: bool = false
var bInstance

func _ready():
	$Character.connect("the_bullet", self, "_shoot")
	$Character.connect("teleport", self, "_teleport")


func _shoot(dShot):
	bInstance = bullet.instance()
	bInstance.dir = dShot
	if dShot.y > 0:
		bInstance.global_position = $Character/DownGun.global_position
	elif dShot.y < 0:
		bInstance.global_position = $Character/UpGun.global_position
	else:
		bInstance.global_position = $Character/Gun.global_position
	if dShot.x < 0:
		bInstance.flipped = true
	add_child(bInstance)


func _teleport():
	$Character.position = bInstance.position
	$Character.velocity.y = 0
	bInstance.queue_free()


func _change_scene():
	var a = name.replace("Map", "")
	var b = int(a)
	var nextScene = str("res://Maps/Map", b +1, "/Map", b +1, ".tscn")
	get_tree().change_scene(nextScene)
