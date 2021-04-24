extends KinematicBody2D

var speed = 50
var velocity = Vector2()
export var direction = -1
export var detects_cliffs=true

func _ready():
	if direction ==1:
		$AnimatedSprite.flip_h=true
	$Edge_detect.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$Edge_detect.enabled = detects_cliffs
	
func _physics_process(delta):
	if is_on_wall() or not $Edge_detect.is_colliding() and detects_cliffs and is_on_floor():
		direction= -direction
		$AnimatedSprite.flip_h= not $AnimatedSprite.flip_h
		$Edge_detect.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	velocity.y+=20
	
	velocity.x=speed*direction
		
	velocity = move_and_slide(velocity,Vector2.UP)




func _on_Attack_check_body_entered(body):
	$AnimatedSprite.play("Damaged")
	speed = 0
	set_collision_layer_bit(5,false)
	set_collision_mask_bit(0,false)
	set_collision_mask_bit(5,false)
	$Attack_check.set_collision_layer_bit(0,false)
	$Sides_check.set_collision_mask_bit(0,false)
	

func _on_Sides_check_body_entered(body):
		print("Got it!")
		get_tree().change_scene("res://Scenes/Lvl1.tscn")