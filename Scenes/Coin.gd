extends Area2D

onready var anim_player: AnimationPlayer=get_node("AnimationPlayer")

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Coin_body_exited(body):
	anim_player.play("fade_out")
	pass # Replace with function body.
