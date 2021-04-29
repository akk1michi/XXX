extends Control


func _ready():
	pass


#exit game
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()


func _on_PlayButton_pressed():
	
	get_tree().change_scene("res://Scenes/Controls.tscn")
	



func _on_LevelButton_pressed():
	pass # Replace with function body.


func _on_CreditsButton_pressed():
	pass # Replace with function body.
