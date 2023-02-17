extends Control

onready var trap = $Colorizer/Traps
onready var act = $Colorizer/Activatable
var bullet = preload("res://Bullet/Bullet.tscn")

var shooting: bool = false
var bInstance

var pickedCollectible: bool = false
var pickedSpecial: bool = false
var haveCoins: bool = false
var haveSpecial: bool = false
#export var unlocked: bool = false
export var lastStage: bool = false
export var preSix: bool = false
export var isSilent: bool = false

func _ready():
	_audio_management()
	_get_world()
	_start_scene()
	$Colorizer/Character.connect("the_bullet", self, "_shoot")
	$Colorizer/Character.connect("teleport", self, "_teleport")
	_change_color()
	print(str("Entrou na fase ", MANAGER.stage, " do mundo ", MANAGER.world))


func _shoot(dShot):
	bInstance = bullet.instance()
	bInstance.dir = dShot
	if dShot.y > 0:
		bInstance.global_position = $Colorizer/Character/DownGun.global_position
	elif dShot.y < 0:
		bInstance.global_position = $Colorizer/Character/UpGun.global_position
	else:
		bInstance.global_position = $Colorizer/Character/Gun.global_position
	if dShot.x < 0:
		bInstance.flipped = true
	$Colorizer.add_child(bInstance)


func _teleport():
	$Colorizer/Character.position = bInstance.position
	$Colorizer/Character.velocity.y = 0
	bInstance.queue_free()


func _get_world():
	var a = str(filename)
	var b = a.replace("res://Maps/World0", "")
	MANAGER.world = int(b[0])


func _change_scene():
	print(str("Saiu da fase ", MANAGER.stage, " do mundo ", MANAGER.world))
	var nextScene
	var stageNumber = int(name.replace("Map", ""))
	
	if get_tree().current_scene.name == "End":
		get_tree().change_scene("res://Menus/MainMenu/Menu.tscn")
	MANAGER.stage = stageNumber
	
	if !preSix: #não é mundo 5 stage 6
		_picked_special() #é fase bonus e checa se pegou estrela
		_picked_collectible() #se é fase normal e pegou moeda
		
		if !lastStage: #se não é última fase (fase antes dos créditos)
			if haveCoins or MANAGER.stage < 5: #se tem todas moedas (na fase 5) ou se não é fase 5
				nextScene = str("res://Maps/World0", MANAGER.world, "/Map0", stageNumber +1, ".tscn")
			else: #se é fase 5 ou 6 e não tem moedas
				nextScene = str("res://Maps/World0", MANAGER.world + 1, "/Map01.tscn")
				MANAGER.world += 1
				MANAGER.playing = false
		else: #se é última fase (fase antes dos créditos)
			nextScene = "res://Menus/Credits/Credits.tscn"
			_stop_song()
	else:
		_stop_song()
		_picked_special() #é fase bonus e checa se pegou estrela
			
		if haveSpecial:
			nextScene = "res://Maps/World06/Map01.tscn"
		else:
			nextScene = "res://Menus/Credits/Credits.tscn"
	
	MANAGER._save()
	get_tree().change_scene(nextScene)


func _picked_special():
	if pickedSpecial: #é fase bonus e pegou estrela
		if MANAGER.specialList[MANAGER.world -1] != 1:
			MANAGER.special += 1
		MANAGER.specialList[MANAGER.world -1] = 1
		var sum: int = 0
		for i in MANAGER.specialList.size():
			sum += MANAGER.specialList[i]
		if sum >= 5:
			haveSpecial = true


func _picked_collectible():
	if pickedCollectible:
		if MANAGER.coins[MANAGER.world -1][MANAGER.stage -1] != 1:
			MANAGER.collectible += 1
		MANAGER.coins[MANAGER.world -1][MANAGER.stage -1] = 1
		var sum: int = 0
		for c in MANAGER.coins[MANAGER.world -1].size():
			sum += MANAGER.coins[MANAGER.world -1][c]
		if sum == 5:
			haveCoins = true


func _change_color():
	if name != "End":
		if MANAGER.world >= 2:
			$Colorizer.modulate = Color("28b642") #VERDE
			if MANAGER.world >= 3:
				$Colorizer.modulate = Color("009dc7") #AZUL
				if MANAGER.world >= 4:
					$Colorizer.modulate = Color("cf72c9") #ROSA
					if MANAGER.world >= 5:
						$Colorizer.modulate = Color("d02b2b") #VERMELHO
						if MANAGER.world >= 6:
							$Colorizer.modulate = Color(0,0,0) #PRETO
		else:
			$Colorizer.modulate = Color("996600") #MARROM/LARANJA
	else:
		$Colorizer.modulate = Color(1,1,1) #BRANCO


func _start_scene():
	if name != "End":
		MANAGER.stage = int(name.replace("Map0", ""))
		if !MANAGER.playing:
			MANAGER._play()
			MANAGER.playing = true
		if MANAGER.stage != 6:
			MANAGER.reached[MANAGER.world -1][MANAGER.stage -1] = 1
		else:
			MANAGER.reached[MANAGER.world -1][MANAGER.stage -1] = 1
			MANAGER.reached[MANAGER.world][0] = 1
	
	if MANAGER.stage != 6:
		if MANAGER.coins[MANAGER.world -1][MANAGER.stage -1] != 0:
			$Colorizer/Collectible.canPick = false
			$Colorizer/Collectible.visible = false
			pickedCollectible = true
	else:
		if MANAGER.specialList[MANAGER.world -1] != 0:
			$Colorizer/Special.canPick = false
			$Colorizer/Special.visible = false
			pickedSpecial = true
	
	MANAGER._save()


func _stop_song():
	for audio in MANAGER.get_node("Songs").get_child_count():
		MANAGER.get_node("Songs").get_child(audio).stop()
		MANAGER.playing = false


func _audio_management():
	MANAGER.onStage = true
	MANAGER.get_node("Menu/Menu").stop()
	MANAGER.playingMenu = false
