extends KinematicBody2D

var speed: int = 200
var velocity = Vector2.ZERO
var dir = Vector2.ZERO

func _ready():
	$Animation.play("Idle")


func _physics_process(delta):
	_movement()
	_collision_handler()


func _movement():
	velocity = dir * speed
	move_and_slide(velocity)


func _collision_handler():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.name == "Character":
			collision.collider._dying()
		else:
			$Animation.play("Collide")
