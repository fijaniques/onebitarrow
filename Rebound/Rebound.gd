extends Area2D

export(int, "RIGHT", "LEFT", "UP", "DOWN") var dir
enum{RIGHT, LEFT, UP, DOWN}
var direction = Vector2.ZERO
var flip: bool

func _ready():
	match dir:
		RIGHT:
			rotation_degrees = 90
			direction = Vector2(1,0)
			flip = false
		LEFT:
			rotation_degrees = -90
			direction = Vector2(-1,0)
			flip = true
		UP:
			rotation_degrees = 0
			direction = Vector2(0,-1)
		DOWN:
			rotation_degrees = 180
			direction = Vector2(0,1)

func _on_Rebound_body_entered(body):
	body.rotation_degrees = rotation_degrees - 90
	body.dir = direction
	body.flipped = flip
	body._animation()
