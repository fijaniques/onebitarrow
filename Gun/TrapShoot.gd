extends KinematicBody2D

onready var ani = $Animation
var speed = 200
var velocity = Vector2.ZERO
var dir = Vector2.ZERO

func _ready():
	$Collider/Collision.set_disabled(false)


func _physics_process(delta):
	_movement()


func _movement():
	velocity = dir * speed
	move_and_slide(velocity)


func _on_Collider_body_entered(body):
	ani.play("Collide")
