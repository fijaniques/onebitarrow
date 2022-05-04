extends Node2D

var world: int
var stage: int = 1
var volume: int = -80

var preSix: int = 0

var playing: bool = false
var playingMenu: bool = false
var onStage: bool = false
var ready21: bool = false
var ready26: bool = false

var collectible: int = 0
var deaths: int = 0

var coins = [[], [], [], [], [], []]
var reached = [[], [], [], [], [], []]

#SAVE
export (Script) var saveClass


func _ready():
	$Menu/Menu.play()
	playingMenu = true
	_fill_reached()
	_fill_coins()
	_load()


func _play():
	if get_tree().current_scene.name != "End":
		if !playing:
			if world != 6:
				$Songs.get_node(str("World", world)).play()
				$Songs.get_node(str("World", world -1)).stop()
			else:
				$Songs.get_node(str("World", world)).play()
				$Songs/World5Pos.stop()
			playing = true


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


func _save():
	var newSave = saveClass.new()
	newSave.collectible = collectible
	newSave.deaths = deaths
	newSave.coins = coins
	newSave.reached = reached
	
	var dir = Directory.new()
	var dirPath = "user://ShootPort/Save"
	if !dir.dir_exists(dirPath):
		dir.make_dir_recursive(dirPath)
	
	ResourceSaver.save("user://ShootPort/Save/save_file.tres", newSave)


func _load():
	var dir = Directory.new()
	var filePath = "user://ShootPort/Save/save_file.tres"
	if !dir.file_exists(filePath):
		return false
	
	var saveState = load(filePath)
	
	collectible = saveState.collectible
	deaths = saveState.deaths
	coins = saveState.coins
	reached = saveState.reached
