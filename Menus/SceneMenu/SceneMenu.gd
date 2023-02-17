extends Control

var pressed: bool = false
var selected: int
var world: int

func _ready():
	MANAGER.onStage = false
	world = 1
	selected = 1
	_set_counters()
	_audio_manager()
	_get_selection()
	_get_world()
	_unlock_check()
	_special_unlock()


func _process(delta):
	MANAGER.get_node("Songs/World5Pos").stop()


func _input(event):
	if Input.is_action_just_pressed("back"):
		MANAGER.get_node("Menu/Back").play()
		get_tree().change_scene("res://Menus/MainMenu/Menu.tscn")
	if Input.is_action_just_pressed("d") and selected < 6 and world != 6 and !pressed:
		MANAGER.get_node("Menu/Change").play()
		pressed = true
		selected += 1
	elif Input.is_action_just_pressed("a") and selected > 1 and world != 6 and !pressed:
		MANAGER.get_node("Menu/Change").play()
		pressed = true
		selected -= 1
	elif Input.is_action_just_pressed("s") and world > 1 and !pressed:
		MANAGER.get_node("Menu/ChangeW").play()
		pressed = true
		selected = 1
		world -= 1
		_get_world()
		_unlock_check()
		_special_unlock()
	elif Input.is_action_just_pressed("up") and world < 6 and !pressed:
		MANAGER.get_node("Menu/ChangeW").play()
		pressed = true
		selected = 1
		world += 1
		_get_world()
		_unlock_check()
		_special_unlock()
	_get_selection()
	
	if Input.is_action_just_released("a") or \
		Input.is_action_just_released("d") or \
		Input.is_action_just_released("s") or \
		Input.is_action_just_released("up"):
		pressed = false

	if Input.is_action_just_pressed("jump"):
		_change_scene()


func _change_scene():
	if MANAGER.reached[world -1][selected -1]:
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


func _special_unlock():
	if world == 6:
		if MANAGER.specialList[world -1] == 1:
			$Selections.get_node("1").get_node("Special").set_visible(true)
		else:
			$Selections.get_node("1").get_node("Special").set_visible(false)
	else:
		$Selections.get_node("1").get_node("Special").set_visible(false)
		if MANAGER.specialList[world -1] == 1:
			$Selections.get_node("6").get_node("Collectible").set_visible(true)
		else:
			$Selections.get_node("6").get_node("Collectible").set_visible(false)


func _unlock_check():
	var sum = 0
	for i in MANAGER.reached[world -1].size():
		sum += MANAGER.coins[world -1][i]
		if MANAGER.reached[world -1][i] == 1:
			$Selections.get_child(i).get_node("Locker").set_visible(false)
		else:
			$Selections.get_child(i).get_node("Locker").set_visible(true)
		
		if i < 5:
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
	$Specials/Label.text = str(MANAGER.special)


func _on_Next_pressed():
	if world < 6:
		MANAGER.get_node("Menu/ChangeW").play()
		world += 1
		selected = 1
		_get_world()
		_unlock_check()
		_special_unlock()


func _on_Previous_pressed():
	if world > 1:
		MANAGER.get_node("Menu/ChangeW").play()
		world -= 1
		selected = 1
		_get_world()
		_unlock_check()
		_special_unlock()


func _on_Back_pressed():
	MANAGER.get_node("Menu/Back").play()
	get_tree().change_scene("res://Menus/MainMenu/Menu.tscn")
