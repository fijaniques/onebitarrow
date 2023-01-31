extends KinematicBody2D

onready var animation =$AnimationPlayer
var flipped = false
var dir = Vector2.ZERO
var speed: float = 200
var velocity = Vector2.ZERO
var initialColor = Vector3()

func _ready():
	initialColor = modulate
	$Collision.disabled = false
	$Position2D.visible = true
	_animation()


func _physics_process(delta):
	_movement()
	_collision_handler()


func _movement():
	velocity = dir * speed
	velocity = move_and_slide(velocity)
	if Input.is_action_just_pressed("free"):
		get_tree().current_scene.get_node("Colorizer").get_node("Character").shooting = false
		animation.play("Free")
		$Free.play()


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
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("colliding_audio"):
			collision.collider.get_node("Audio").play()
		else:
			$Arrow.play()
		dir = Vector2.ZERO
		get_tree().current_scene.get_node("Colorizer").get_node("Character").shooting = false
		get_tree().current_scene.shooting = false
		get_tree().current_scene.get_node("Colorizer").get_node("Character").canShoot = true
		animation.play("Free")


func _reset():
	get_tree().current_scene.get_node("Colorizer").get_node("Character").shooting = false
	get_tree().current_scene.shooting = false
	get_tree().current_scene.get_node("Colorizer").get_node("Character").canShoot = true
	queue_free()


func _on_ColorChanger_body_entered(body):
	if body.is_in_group("Traps"):
		modulate = Color(0.18,0.18,0.18)


func _on_ColorChanger_body_exited(body):
	modulate = initialColor
