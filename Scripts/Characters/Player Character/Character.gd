extends KinematicBody2D


var coins=0

var speed
const maxspeed=200
var gravity=30
var jumpForce=600
var wall_direction=1
var can_jump=false
var wall_jump=true


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
		$AnimationTree.set("parameters/JumpStart/blend_position",input_x)
		$AnimationTree.set("parameters/JumpLoop/blend_position",input_x)
		$AnimationTree.set("parameters/Wall/blend_position",input_x)
		$AnimationTree.get("parameters/playback").travel("Run")
	elif Input.is_action_pressed("Left"):
		face=false
		velocity.x=-maxspeed
		input_x=-1
		$AnimationTree.set("parameters/Idle/blend_position",input_x)
		$AnimationTree.set("parameters/Run/blend_position",input_x)
		$AnimationTree.set("parameters/JumpStart/blend_position",input_x)
		$AnimationTree.set("parameters/JumpLoop/blend_position",input_x)
		$AnimationTree.set("parameters/Wall/blend_position",input_x)
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
	if !is_on_floor():
		$AnimationTree.get("parameters/playback").travel("JumpLoop")
	if is_on_floor():
		can_jump=true
		wall_jump=true
	elif !(is_on_floor()||is_on_wall()):
		can_jump=false
	
		
	if Input.is_action_pressed("Jump"):
		if can_jump==true:
			velocity.y=-jumpForce
#			if is_on_wall() && Input.is_action_pressed("Right"):
#				wall_jump=false
#				velocity.x=-(maxspeed+300)
#			elif is_on_wall() && Input.is_action_pressed("Left"):
#				wall_jump=false
#				velocity.x=maxspeed+300
				
		
		
#	if Input.is_action_pressed("Jump") and is_on_floor(): #hold down jump to repeatedly jump, feels nicer to platform
#		velocity.y=-jumpForce  
	velocity = move_and_slide(velocity,Vector2.UP)
	#if is_on_floor()
		#velocity.y+=gravity
	velocity.x=lerp(velocity.x,0,0.2)

	if !is_on_floor()&&is_on_wall() &&(Input.is_action_pressed("Right")||Input.is_action_pressed("Left")):
		$AnimationTree.get("parameters/playback").travel("Wall")
		if velocity.y>=0:
			velocity.y=min(velocity.y+20,120)
		else:
			velocity.y+=gravity
	else:
			velocity.y+=gravity	
	




	#fallzone
func _on_Fallzone_body_entered(body):
	get_tree().reload_current_scene()

#bounce after kill
func bounce():
	velocity.y=-jumpForce*0.6
	Input.action_release("Jump")
	
	

#coin
func add_coin():
	coins=coins+1

#hit
func hit(var eposx):
	$Timer.start()
	set_modulate(Color(1,0.2,0.2,0.3))
	velocity.y=-jumpForce*0.6
	if position.x<eposx:
		velocity.x=-800
	elif position.x>eposx:
		velocity.x=900
	Input.action_release("Left")
	Input.action_release("Right")
	#Subtract health amount before timer ends
	
func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
	
