extends Node2D

var stage: int = 1
var playing: bool = false
var ready21: bool = false

func _play():
	if !playing and stage < 20:
		playing = true
		$Theme.play()
	elif stage == 20:
		playing = false
		$HardIntro.play()
		$Theme.stop()
	elif stage > 20 and !playing:
		playing = true
		$HardTheme.play()


func _on_HardIntro_finished():
	$HardIntro.play()
	if ready21:
		ready21 = false
		$HardIntro.stop()
		get_tree().current_scene._change_scene()
