extends Area2D

var needKey: bool = false
var haveKey: bool = false

func _set_start():
	if MANAGER.stage > 20:
		$Sprite.visible = true
		set_collision_mask_bit(2, false)
		needKey = true


func _on_Door_body_entered(body):
	if needKey:
		if haveKey:
			_change_scene()
	else:
		_change_scene()


func _change_scene():
	get_tree().current_scene.get_node("Colorizer").get_node("Character").visible = false
	if get_tree().current_scene.shooting:
		get_tree().current_scene.get_node("bInstance").queue_free()
	if MANAGER.stage == 20:
		MANAGER.ready21 = true
		get_tree().current_scene.get_node("FG").visible = true
	else:
		get_tree().current_scene._change_scene()


func _open_door():
	set_collision_mask_bit(2, true)
	$AnimationPlayer.play("Open")
