extends Control


func _ready():
	$Timer.start()
	
	
	
func _on_Timer_timeout():
	set_modulate(Color(0,0,0,1))
	get_tree().change_scene("res://Scenes/Lvl1.tscn")
