extends KinematicBody2D

onready var animation =$AnimationPlayer
var flipped = false
var dir = Vector2.ZERO
var speed: float = 200
var velocity = Vector2.ZERO

func _ready():
	$Collision.disabled = false
	$Position2D.visible = true
	_animation()


func _physics_process(delta):
	_movement()
	_collision_handler()


func _movement():
	velocity = dir * speed
	velocity = move_and_slide(velocity)


func _animation():
	if flipped:
		$Sprite.flip_h = true
		$Position2D.position.x = 5
		$Position2D/Particles.flip_h = true
	else:
		$Sprite.flip_h = false
	if dir.y > 0:
		rotation_degrees = 90
	elif dir.y < 0:
		rotation_degrees = -90


func _collision_handler():
	for i in get_slide_count():
		$Arrow.play()
		dir = Vector2.ZERO
		get_tree().current_scene.get_node("Character").shooting = false
		animation.play("Free")


func _on_VisibilityNotifier2D_screen_exited():
	_reset()


func _reset():
	get_tree().current_scene.shooting = false
	get_tree().current_scene.get_node("Character").shooting = false
	queue_free()
