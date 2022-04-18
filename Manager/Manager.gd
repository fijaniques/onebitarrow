extends Node2D

var stage: int = 1

var playing: bool = false
var ready21: bool = false
var ready26: bool = false

var collectible: int = 0

func _play():
	if !playing and stage < 20:
		playing = true
		$Theme.play()
	elif stage == 20:
		playing = false
		$HardIntro.play()
		$Theme.stop()
	elif stage > 20 and stage < 25 and !playing:
		playing = true
		$HardTheme.play()
	elif stage == 25:
		playing = false
		$FinalIntro.play()
		$HardTheme.stop()
	elif stage > 25 and !playing:
		playing = true
		$Final.play()
		


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
