extends Area2D

var canPick: bool = true

func _ready():
	$Animation.play("Normal")


func _process(delta):
	if Input.is_action_just_pressed("collect_s"):
		_picked()


func _picked():
	if canPick:
		get_tree().current_scene.pickedSpecial = true
		canPick = false
		visible = false
		$Pick.play()


func _on_Pick_finished():
	queue_free()


func _on_Special_body_entered(body):
	_picked()
