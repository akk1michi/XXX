extends KinematicBody2D
var speed
const maxspeed=200
var gravity=30
var jumpForce=600
var velocity=Vector2(0,0)
var face=true
func _physics_process(delta):
	if Input.is_action_pressed("Right"):
		face=true
		velocity.x=maxspeed
		$AnimatedSprite.play("Run_Right")
	elif Input.is_action_pressed("Left"):
		face=false
		velocity.x=-maxspeed
		$AnimatedSprite.play("Run_Left")
	elif face==true:
		$AnimatedSprite.play("Idle_Right")
	else:
		$AnimatedSprite.play("Idle_Left")
	
	if Input.is_action_pressed("Down"):
		set_collision_mask_bit(1,false)
	else:
		set_collision_mask_bit(1,true)
		
		
	velocity.y+=gravity
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y=-jumpForce
	velocity = move_and_slide(velocity,Vector2.UP)
	#if is_on_floor()
		#velocity.y+=gravity
	velocity.x=lerp(velocity.x,0,0.2)
