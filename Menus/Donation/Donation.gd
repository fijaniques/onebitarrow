extends Control

func _on_LinkButton_pressed():
	OS.shell_open("https://www.paypal.com/donate/?hosted_button_id=LRCMCHDYGKB68")


func _on_Back_pressed():
	MANAGER.get_node("Menu/Back").play()
	get_tree().change_scene("res://Menus/MainMenu/Menu.tscn")
