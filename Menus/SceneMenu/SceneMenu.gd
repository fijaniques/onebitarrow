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


func _input(event):
	if Input.is_action_just_pressed("back"):
		MANAGER.get_node("Menu/Back").play()
		get_tree().change_scene("res://Menus/MainMenu/Menu.tscn")
	if Input.is_action_just_pressed("d") and selected < 6 and world != 6:
		MANAGER.get_node("Menu/Change").play()
		selected += 1
	elif Input.is_action_just_pressed("a") and selected > 1 and world != 6:
		MANAGER.get_node("Menu/Change").play()
		selected -= 1
	elif Input.is_action_just_pressed("s") and world > 1:
		selected = 1
		world -= 1
		_get_world()
		_unlock_check()
	elif Input.is_action_just_pressed("up") and world < 6:
		selected = 1
		world += 1
		_get_world()
		_unlock_check()
	_get_selection()
	if MANAGER.reached[world -1][selected -1]:
		if Input.is_action_just_pressed("jump"):
			MANAGER.get_node("Menu/Accept").play()
			var scene = str("res://Maps/World0", world, "/Map0", selected, "/Map0", selected, ".tscn")
			get_tree().change_scene(scene)


func _get_selection():
	$Selection.position = get_node(str("Selections/", selected)).position - Vector2(4,4)


func _get_world():
	$World.text = str(world)
	_colorize()
	if world == 6:
		for c in $Colorizer.get_child_count():
			if c > 0:
				$Colorizer.get_child(c).set_visible(false)
				$Selections.get_child(c).set_visible(false)
	else:
		for c in $Colorizer.get_child_count():
			$Colorizer.get_child(c).set_visible(true)
			$Selections.get_child(c).set_visible(true)


func _unlock_check():
	var sum = 0
	for i in MANAGER.reached[world -1].size():
		sum += MANAGER.coins[world -1][i]
		print(sum)
		if MANAGER.reached[world -1][i] == 1:
			$Selections.get_child(i).get_node("Locker").set_visible(false)
		else:
			$Selections.get_child(i).get_node("Locker").set_visible(true)
		
		if MANAGER.coins[world -1][i] == 1:
			$Selections.get_child(i).get_node("Collectible").set_visible(true)
		else:
			$Selections.get_child(i).get_node("Collectible").set_visible(false)
	if sum >= 5:
		$Selections.get_node("6/Locker").set_visible(false)
		MANAGER.reached[world -1][5] = 1


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
	if !MANAGER.playingMenu:
		MANAGER.get_node("Menu/Menu").play()
		MANAGER.playingMenu = true


func _set_counters():
	$Collectibles/Label.text = str(MANAGER.collectible)
	$DeathCount/Label.text = str(MANAGER.deaths)
