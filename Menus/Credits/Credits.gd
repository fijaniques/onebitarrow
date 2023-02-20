extends Control

onready var names = $Names
var person = ["Allan Defensor", "Got further than anyone else in the game and found a lot of bugs",
"Danilo Pacheco", "'I can't... I just can't'",
"Davi Alcantara", "'This should have double jump'",
"Fernando Proenca", "First one to make it to 100%",
"Italo Cuzziol", "Helped a lot with coding",
"Luiz Whiskey", "Helped with fine tuning",
"Marlon Marinho", "'This game isn't fun'",
"Nina Zambardino", "Made me keep going and didn't get mad with me spending all my time with this",
"Rafael Martinelli", "Found a lot of bugs",
"Renan Castro", "Gave me some nice ideas",
"Robson Moreira", "Made me learn how to make an android version",
"Thomas Meneghelli", "Spilled his schweppes all over the keyboard just to play the game",
"Vitor", "Gave me some good ideas",
"Edgar Brito", "'I will play... I swear I will'",
"Eliane 'Mom'", "The real reason I'm alive",
"Guilherme Figueiredo", "'As soon as I get home I'll play'",
"Jonas 'Dad'", "The other real reason I'm alive (R.I.P)",
"Kadu Ciccone", "'Being honest, I wouldn't play this game on PC'",
"Mary Christensen", "'We need to beat Linas up'"]

var count: int = 0

func _ready():
	_audio_management()
	_change_text()


func _audio_management():
	for song in MANAGER.get_node("Songs").get_child_count():
		MANAGER.get_node("Songs").get_child(song).stop()
	for song in MANAGER.get_node("Menu").get_child_count():
		MANAGER.get_node("Menu").get_child(song).stop()
	MANAGER.get_node("Songs/PreCredit").play()


func _on_Timer_timeout():
	count += 2
	if !names.text == "Mary Christensen":
		_change_text()
	else:
		get_tree().change_scene("res://Maps/End/End.tscn")


func _change_text():
	$AddInfo.text = person[count +1]
	
	if count > 24:
		$Testers.set_visible(false)
		$Special.set_visible(true)
	
	names.text = person[count]
