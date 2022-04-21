extends Node2D

var world: int
var stage: int = 1

var preSix: int = 0

var playing: bool = false
var ready21: bool = false
var ready26: bool = false

var collectible: int = 0

var coins = [[], [], [], [], [], []]
var reached = [[], [], [], [], [], []]

func _ready():
	for i in reached.size():
		for c in reached.size():
			reached[i].append(0)


func _play():
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
