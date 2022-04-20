extends Timer

onready var switchCheck = get_tree().current_scene.get_node("Colorizer").get_node("Switches")
onready var gunCheck = get_tree().current_scene.get_node("Colorizer").get_node("Guns")

func _ready():
	start()


func _on_Timer_timeout():
	if switchCheck.get_child_count() > 0 and switchCheck.get_child(0).timerActive:
		get_tree().current_scene.get_node("Colorizer").get_node("Switches").get_child(0)._activatable_change()
	if gunCheck.get_child_count() > 0:
		for gun in gunCheck.get_child_count():
			gunCheck.get_child(gun)._shoot()
