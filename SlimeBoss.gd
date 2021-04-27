extends KinematicBody2D

var speed = 50
var velocity = Vector2()
var boss_health = 3
export var direction = -1
export var detects_cliffs=true

func _ready():
	if direction ==1:
		$AnimatedSprite.flip_h=true
	$Edge_detect.position.x = $CollisionShape2D.shape.get_extents().x * direction
	$Edge_detect.enabled = detects_cliffs
	if detects_cliffs:
		set_modulate(Color(0.5,0.5,1,1))
	
func _physics_process(delta):
	if is_on_wall() or not $Edge_detect.is_colliding() and detects_cliffs and is_on_floor():
		direction= -direction
		$AnimatedSprite.flip_h= not $AnimatedSprite.flip_h
		$Edge_detect.position.x = $CollisionShape2D.shape.get_extents().x * direction
	
	velocity.y+=20
	
	velocity.x=speed*direction
		
	velocity = move_and_slide(velocity,Vector2.UP)




func _on_Attack_check_body_entered(body):

	boss_health=boss_health-1
	
	
	if boss_health==0:
		$AnimatedSprite.play("Damaged")
		speed = 0
		set_collision_layer_bit(5,false)
		set_collision_mask_bit(0,false)
		set_collision_mask_bit(5,false)
		$Attack_check.set_collision_layer_bit(0,false)
		$Sides_check.set_collision_mask_bit(0,false)
		$Timer.start()
		body.bounce()

func _on_Sides_check_body_entered(body):
		print("Got it!")
		body.hit(position.x)
		#get_tree().change_scene("res://Scenes/Lvl1.tscn")


func _on_Timer_timeout():
	if boss_health==0:
		queue_free()
