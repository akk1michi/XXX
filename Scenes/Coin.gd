extends Area2D

onready var anim_player: AnimationPlayer=get_node("AnimationPlayer")


func _ready():
	pass 





func _on_Coin_body_exited(body):
	anim_player.play("fade_out")
	pass # Replace with function body.
