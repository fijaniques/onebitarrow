extends Sprite

onready var timer = get_tree().current_scene.get_node("Timers").get_child(0)
var bullet = preload("res://Gun/TrapShoot.tscn")
var direction = Vector2.ZERO

func _ready():
	_check_direction()


func _shoot():
	$Shoot.play()
	var bInstance = bullet.instance()
	bInstance.dir = direction
	bInstance.global_position = global_position
	get_tree().current_scene.get_node("Colorizer").add_child(bInstance)


func _check_direction():
	if rotation_degrees >= 1 and rotation_degrees <= 170:
		direction.x = 1
	elif rotation_degrees >= -100 and rotation_degrees <= -1:
		direction.x = -1
	elif rotation_degrees >= 160 and rotation_degrees <= 200:
		direction.y = 1
	elif rotation_degrees == 0:
		direction.y = -1
