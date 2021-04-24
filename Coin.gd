extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")
# Declare member variables here. Examples:
# var a = 2
# var b = "text"



func _ready():
	pass 



func _on_Coin_body_entered(body):
	anim_player.play("fade")
	body.add_coin()
	
	pass 
