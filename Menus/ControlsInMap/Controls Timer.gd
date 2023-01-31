extends Timer

var first: bool = true

func _on_Controls_Timer_timeout():
	if first:
		get_tree().current_scene.get_node("Controls/Controls1").set_visible(true)
		get_tree().current_scene.get_node("Controls/Controls2").set_visible(false)
	else:
		get_tree().current_scene.get_node("Controls/Controls2").set_visible(true)
		get_tree().current_scene.get_node("Controls/Controls1").set_visible(false)
	
	first = !first
