extends Area2D

onready var anim_player: AnimationPlayer = get_node("AnimationPlayer")

signal heart_collected

func _on_Heart_body_entered(body):
	$AnimationPlayer.play("fade")
	
	body.add_health()
	
	emit_signal("heart_collected")
	set_collision_mask_bit(0,0)

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
			  
