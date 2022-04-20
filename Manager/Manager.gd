extends Node2D

var world: int
var stage: int = 1

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
		if world == 1:
			playing = true
			$World1.play()
		elif world == 2:
			playing = true
			$World1.stop()
			$World2.play()
		elif world == 3:
			playing = true
			$World2.stop()
			$World3.play()
		elif world == 4:
			playing = true
			$World3.stop()
			$World4.play()
		elif world == 5:
			playing = true
			$World4.stop()
			$World5.play()
		elif world == 6:
			playing = true
			$World5.stop()
			$World6.play()


func _on_HardIntro_finished():
	if ready21:
		ready21 = false
		$HardIntro.stop()
		get_tree().current_scene._change_scene()
	else:
		$HardIntro.play()


func _on_FinalIntro_finished():
	if ready26:
		ready26 = false
		$FinalIntro.stop()
		get_tree().current_scene._change_scene()
	else:
		$FinalIntro.play()
