extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")


signal coin_collected



func _on_Coin_body_entered(body):
	$AnimationPlayer.play("fade")
	body.add_coin()
	emit_signal("coin_collected")
	set_collision_mask_bit(0,0) #disable mask for no double coin pickup
	
	


func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
