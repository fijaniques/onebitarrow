extends Area2D

var canPick: bool = true

func _ready():
	$Animation.play("Normal")


func _on_Collectible_body_entered(body):
	if canPick:
		get_tree().current_scene.collectible = true
		canPick = false
		visible = false
		$Pick.play()


func _on_Pick_finished():
	queue_free()
