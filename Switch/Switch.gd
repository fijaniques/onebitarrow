extends Area2D

onready var ani = $AnimationPlayer

func _ready():
	ani.play("Normal")


func _on_Switch_body_entered(body):
	$Audio.play()
	if ani.is_playing():
		_activatable_change()
		ani.stop()
	else:
		_activatable_change()
		ani.play("Normal")


func _activatable_change():
		if get_tree().current_scene.get_node("Colorizer").get_node("Activatable").visible:
			get_tree().current_scene.get_node("Colorizer").get_node("Activatable").visible = false
			get_tree().current_scene.get_node("Colorizer").get_node("Activatable").set_collision_layer_bit(0, false)
		else:
			get_tree().current_scene.get_node("Colorizer").get_node("Activatable").visible = true
			get_tree().current_scene.get_node("Colorizer").get_node("Activatable").set_collision_layer_bit(0, true)

		if get_tree().current_scene.get_node("Colorizer").get_node("Activatable2").visible:
			get_tree().current_scene.get_node("Colorizer").get_node("Activatable2").visible = false
			get_tree().current_scene.get_node("Colorizer").get_node("Activatable2").set_collision_layer_bit(0, false)
		else:
			get_tree().current_scene.get_node("Colorizer").get_node("Activatable2").visible = true
			get_tree().current_scene.get_node("Colorizer").get_node("Activatable2").set_collision_layer_bit(0, true)
