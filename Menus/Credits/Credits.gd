extends Control

onready var names = $Names
var person = ["Allan Defensor",
"Danilo Pacheco",
"Davi Alcantara", 
"Fernando Proenca",
"Italo Cuzziol",
"Luiz Whiskey",
"Marlon Marinho",
"Nina Zambardino",
"Rafael Martinelli",
"Renan Castro",
"Robson Moreira",
"Thomas Meneghelli",
"Vitor",
"Edgar Brito",
"Eliane 'Mom'",
"Guilherme Figueiredo",
"Jonas 'Dad'",
"Kadu Ciccone",
"Mary Christensen"]
var text = ["Got further than anyone else in the game and found a lot of bugs",
"'I can't... I just can't'",
"'This should have double jump'",
"Coundn't really play 'cause of a broken thumb",
"Helped a lot with coding",
"Helped with fine tuning",
"'This game isn't fun'",
"Made me keep going and didn't get mad with me spending all my time with this",
"Found a lot of bugs",
"Gave me some nice ideas",
"Made me learn how to make an android version",
"Spilled his schweppes all over the keyboard just to play the game",
"Gave me some nice ideas",
"'I will play... I swear I will'",
"The real reason I'm alive",
"'As soon as I get home I'll play'",
"The other real reason I'm alive (R.I.P)",
"'Being honest, I wouldn't play this game on PC'",
"'We need to beat Linas up'"]
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
	count += 1
	if !names.text == "Mary Christensen":
		_change_text()
	else:
		get_tree().change_scene("res://Maps/End/End.tscn")


func _change_text():
	$AddInfo.text = text[count]
	
	if count > 12:
		$Testers.set_visible(false)
		$Special.set_visible(true)
	
	names.text = person[count]
