extends Control


func _ready():
	pass


func _on_TryAgain_pressed():
	get_tree().change_scene("res://Scenes/Lvl1.tscn")


func _on_BackToMenu_pressed():
	get_tree().change_scene("res://Scenes/TitleMenu.tscn")
	
