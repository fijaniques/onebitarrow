extends Area2D

func _ready():
	$Animation.play("Normal")


func _on_Collectible_body_entered(body):
	queue_free()
