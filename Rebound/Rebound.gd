extends Area2D

var direction = Vector2.ZERO
var flip: bool

func _ready():
	if rotation_degrees >= 1 and rotation_degrees <= 170:
		direction.x = 1
	elif rotation_degrees >= -100 and rotation_degrees <= -1:
		direction.x = -1
	elif rotation_degrees >= 160 and rotation_degrees <= 200:
		direction.y = 1
	elif rotation_degrees == 0:
		direction.y = -1


func _on_Rebound_body_entered(body):
	$Audio.play()
	body.global_position = global_position
	if !body.flipped:
		body.set_rotation_degrees(rotation_degrees -90)
	else:
		body.set_rotation_degrees(rotation_degrees +90)
	body.dir = direction
