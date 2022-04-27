extends Control

var selected: int
var world: int

func _ready():
	world = 1
	selected = 1
	_set_counters()
	_audio_manager()
	_get_selection()
	_get_world()
	_unlock_check()
	_collect_check()


func _input(event):
	if Input.is_action_just_pressed("back"):
		get_tree().change_scene("res://Menus/MainMenu/Menu.tscn")
	if Input.is_action_just_pressed("d") and selected < 6:
		selected += 1
	elif Input.is_action_just_pressed("a") and selected > 1:
		selected -= 1
	elif Input.is_action_just_pressed("s") and world > 1:
		world -= 1
		_get_world()
		_collect_check()
		_unlock_check()
	elif Input.is_action_just_pressed("up") and world < 6:
		world += 1
		_get_world()
		_collect_check()
		_unlock_check()
	_get_selection()
	if MANAGER.reached[world -1][selected -1]:
		if Input.is_action_just_pressed("jump"):
			var scene = str("res://Maps/World0", world, "/Map0", selected, "/Map0", selected, ".tscn")
			get_tree().change_scene(scene)


func _get_selection():
	$Selection.position = get_node(str("Selections/", selected)).position - Vector2(4,4)


func _get_world():
	$World.text = str(world)
	_colorize()


func _unlock_check():
	for i in MANAGER.reached[world -1].size():
		if MANAGER.reached[world -1][i] == 1:
			$Selections.get_child(i).get_node("Locker").set_visible(false)
		else:
			$Selections.get_child(i).get_node("Locker").set_visible(true)
		
		if MANAGER.coins[world -1][i] == 1:
			$Selections.get_child(i).get_node("Collectible").set_visible(true)
		else:
			$Selections.get_child(i).get_node("Collectible").set_visible(false)


func _collect_check():
	pass


func _colorize():
	if world >= 2:
		$Colorizer.modulate = Color("28b642") #VERDE
		if world >= 3:
			$Colorizer.modulate = Color("009dc7") #AZUL
			if world >= 4:
				$Colorizer.modulate = Color("cf72c9") #ROSA
				if world >= 5:
					$Colorizer.modulate = Color("d02b2b") #VERMELHO
					if world == 6:
						$Colorizer.modulate = Color(0,0,0) #PRETO
	else:
		$Colorizer.modulate = Color("996600") #MARROM/LARANJA


func _audio_manager():
	MANAGER.playing = false
	for audio in MANAGER.get_node("Songs").get_child_count():
		MANAGER.get_node("Songs").get_child(audio).stop()


func _set_counters():
	$Collectibles/Label.text = str(MANAGER.collectible)
	$DeathCount/Label.text = str(MANAGER.deaths)
