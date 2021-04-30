extends Control


func _ready():
	yield(get_tree().create_timer(2.0), "timeout")
	get_tree().change_scene("res://Scenes/Lvl2.tscn")
