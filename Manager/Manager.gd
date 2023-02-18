extends Node2D

var world: int = 1
var stage: int = 1
var volume: int = -80

var preSix: int = 0

var playing: bool = false
var playingMenu: bool = false
var onStage: bool = false
var ready21: bool = false
var ready26: bool = false

var collectible: int = 0
var special: int = 0
var deaths: int = 0

var worlds: int = 6
var coins = [[], [], [], [], [], []]
var specialList = []
var reached = [[], [], [], [], [], []]

#SAVE
export (Script) var saveClass


func _ready():
	playingMenu = true
	_fill_reached()
	_fill_coins()
	_fill_special()
	_load()


func _input(event):
	if event is InputEventKey:
		if event.pressed:
			print(event.scancode)
	
	if event is InputEventJoypadButton:
		if event.pressed:
			print(event.button_index)
	
	if event is InputEventKey and event.scancode == 16777220 and event.pressed:
		print("-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+")
	if event is InputEventJoypadButton and event.button_index == 10 and event.pressed:
		print("-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+")


func _play():
	if get_tree().current_scene.name != "End":
		if !get_tree().current_scene.isSilent:
			if !playing:
				if world != 6:
					$Songs.get_node(str("World", world)).play()
					$Songs.get_node(str("World", world -1)).stop()
				else:
					$Songs.get_node(str("World", world)).play()
					$Songs/World5Pos.stop()
				playing = true
		else:
			for song in $Songs.get_child_count():
				$Songs.get_child(song).stop()


func _on_HardIntro_finished():
	if ready21:
		ready21 = false
		$HardIntro.stop()
		get_tree().current_scene._change_scene()
	else:
		$HardIntro.play()


func _on_World6_finished():
	if preSix < 1:
		$Songs/World6.play()
		preSix +=1
	else:
		$Songs/World6Pos.play()


func _on_World5_finished():
	$Songs/World5Pos.play()


func _on_PreCredit_finished():
	$Songs/Credit.play()


func _fill_reached():
	for i in reached.size():
		for c in reached.size():
			reached[i].append(0)
	reached[0][0] = 1
	reached[5].clear()
	reached[5].append(0)


func _fill_coins():
	for i in coins.size():
		for c in coins.size():
			coins[i].append(0)


func _fill_special():
	for i in range(0,6):
		specialList.append(0)


func _save():
	var newSave = saveClass.new()
	newSave.collectible = collectible
	newSave.special = special
	newSave.deaths = deaths
	newSave.coins = coins
	newSave.reached = reached
	newSave.specialList = specialList
	
	var dir = Directory.new()
	var dirPath = "user://Save/"
	if !dir.dir_exists(dirPath):
		dir.make_dir_recursive(dirPath)
	
	ResourceSaver.save(dirPath + "/save_file.tres", newSave)


func _load():
	var dir = Directory.new()
	var filePath = "user://Save/save_file.tres"
	if !dir.file_exists(filePath):
		return false
	
	var saveState = load(filePath)
	
	collectible = saveState.collectible
	special = saveState.special
	deaths = saveState.deaths
	coins = saveState.coins
	reached = saveState.reached
	specialList = saveState.specialList
