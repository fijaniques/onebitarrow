extends KinematicBody2D

const UP = Vector2.UP
var gravity: float = 10

#MOVEMENT
var speed: float = 100
var velocity = Vector2.ZERO
var jumpForce: float = 200
var hDir: float
var canMove: bool = true

#ANIMATION
onready var animation = $AnimationPlayer
export var flipped: bool = false
var dead: bool = false

#SHOOT
var bullet = preload("res://Bullet/Bullet.tscn")
var shooting: bool = false
var dShot = Vector2.ZERO
var canShoot: bool = true
export var shootAnim: bool = false
signal the_bullet 
signal teleport

func _process(delta):
	_animation()


func _physics_process(delta):
	_get_input()
	_movement()
	_trap_collision()


func _get_input():
	if canMove:
		hDir = Input.get_action_strength("d") - Input.get_action_strength("a")
		if hDir > 0:
			hDir = 1
		elif hDir < 0:
			hDir = -1


	if Input.is_action_just_pressed("shoot"):
		if !shooting and canShoot:
			_shoot()
		elif shooting and !canShoot:
			_teleport()
	
	if Input.is_action_just_pressed("jump") and is_on_floor():
		_jump()


func _movement():
	velocity.y += gravity
	velocity.x = hDir * speed
	velocity = move_and_slide(velocity, UP)


func _jump():
	$Audio/Jump.play()
	velocity.y -= jumpForce


func _shoot():
	$Audio/Shoot.play()
	shooting = true
	shootAnim = true
	canShoot = false
	if Input.is_action_pressed("up"):
		dShot = Vector2(0, -1)
		animation.play("ShootUp")
	elif Input.is_action_pressed("s"):
		dShot = Vector2(0, 1)
		animation.play("ShootDown")
	else:
		if flipped:
			dShot = Vector2(-1, 0)
		else:
			dShot = Vector2(1, 0)
		animation.play("Shoot")
	emit_signal("the_bullet", dShot)


func _teleport():
	$Audio/Teleport.play()
	emit_signal("teleport")
	shooting = false
	canShoot = true
	_jump()


func _trap_collision():
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		if collision.collider.is_in_group("Traps"):
			_dying()


func _dying():
	$Audio/Death.play()
	canMove = false
	canShoot = false
	dead = true
	animation.play("Dead")


func _dead():
# warning-ignore:return_value_discarded
	MANAGER.deaths += 1
	MANAGER._save()
	get_tree().reload_current_scene()


func _animation():
	if !dead:
		if !shootAnim:
			if velocity.x < 0:
				flipped = true
				
			elif velocity.x > 0:
				flipped = false

			if flipped:
				$Sprite.flip_h = true
				$Gun.position.x = -10
			else:
				$Sprite.flip_h = false
				$Gun.position.x = 10
			
			if is_on_floor():
				if hDir != 0:
					animation.play("Walk")
				else:
					animation.play("Idle")
			else:
				animation.play("Jump")
			
			if Input.is_action_pressed("up"):
				animation.play("ShootUp")
			elif Input.is_action_pressed("s"):
				animation.play("ShootDown")


func _on_Killer_body_entered(body):
	_dying()
