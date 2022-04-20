extends Control

var selected: int
var world: int

func _ready():
	selected = 1
	_get_selection()
	_colorize()
	_get_world()
	_unlock_check()


func _input(event):
	if Input.is_action_just_pressed("d") and selected < 6:
		selected += 1
	elif Input.is_action_just_pressed("a") and selected > 1:
		selected -= 1
	elif Input.is_action_just_pressed("s") and selected < 4:
		selected += 3
	elif Input.is_action_just_pressed("up") and selected > 3:
		selected -= 3
	_get_selection()
	
	if Input.is_action_just_pressed("jump"):
		var scene = str("res://Maps/World0", world, "/Map0", selected, "/Map0", selected, ".tscn")
		get_tree().change_scene(scene)


func _get_selection():
	$Selection.position = get_node(str("Selections/", selected)).position - Vector2(4,4)


func _get_world():
	var a = name.replace("SceneMenu", "")
	world = int(a)


func _unlock_check():
	for c in $Selections.get_child_count():
		var a = str("col", c +1)
		if a:
			print("OK")
			get_node(str("Selections/", c +1, "/Locker")).visible = false


func _colorize():
	if world == 2:
		$Colorizer.modulate = Color("28b642") #VERDE
		if world == 3:
			$Colorizer.modulate = Color("009dc7") #AZUL
			if world == 4:
				$Colorizer.modulate = Color("cf72c9") #ROSA
				if world == 5:
					$Colorizer.modulate = Color("d02b2b") #VERMELHO
					if world == 6:
						$Colorizer.modulate = Color(0,0,0) #PRETO
	else:
		$Colorizer.modulate = Color("996600") #MARROM/LARANJA
