extends KinematicBody2D

var speed: int = 200
var velocity = Vector2.ZERO
var dir = Vector2.ZERO

func _ready():
	$Animation.play("Idle")


func _physics_process(delta):
	_movement()


func _movement():
	velocity = dir * speed
	move_and_slide(velocity)


func _on_Collider_body_entered(body):
	dir = Vector2.ZERO
	$Animation.play("Collide")
