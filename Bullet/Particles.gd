extends Sprite

onready var animation = $AnimationPlayer

func _ready():
	animation.play("Normal")
