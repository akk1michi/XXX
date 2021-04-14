extends KinematicBody2D
var speed
const maxspeed=200
var gravity=30
var jumpForce=600
var velocity=Vector2(0,0)
var input_x=1
var face=true
func _physics_process(delta):
	if Input.is_action_pressed("Right"):
		face=true
		velocity.x=maxspeed
		input_x=1
		$AnimationTree.set("parameters/Idle/blend_position",input_x)
		$AnimationTree.set("parameters/Run/blend_position",input_x)
		$AnimationTree.get("parameters/playback").travel("Run")
	elif Input.is_action_pressed("Left"):
		face=false
		velocity.x=-maxspeed
		input_x=-1
		$AnimationTree.set("parameters/Idle/blend_position",input_x)
		$AnimationTree.set("parameters/Run/blend_position",input_x)
		$AnimationTree.get("parameters/playback").travel("Run")
	else:
		$AnimationTree.get("parameters/playback").travel("Idle")
#	elif face==true:
#		$AnimationPlayer.play("Idle_Right")
#	else:
#		$AnimationPlayer.play("Idle_Left")
	
	if Input.is_action_pressed("Down"):
		set_collision_mask_bit(2,false)
	else:
		set_collision_mask_bit(2,true)
		
		
	velocity.y+=gravity
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y=-jumpForce
	if Input.is_action_pressed("Jump") and is_on_floor(): #hold down jump to repeatedly jump, feels nicer to platform
		velocity.y=-jumpForce  
	velocity = move_and_slide(velocity,Vector2.UP)
	#if is_on_floor()
		#velocity.y+=gravity
	velocity.x=lerp(velocity.x,0,0.2)


func _on_Fallzone_body_entered(body):
	get_tree().reload_current_scene()
