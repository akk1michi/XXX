extends KinematicBody2D


var coins=0
onready var health = 6

var speed
const maxspeed=250
var gravity=30
var jumpForce=600
var wall_direction=1
#var can_jump=false
#var wall_jump=true


var stopping_friction = 0.6
var running_friction = 0.9
var can_dash=false
var dash_direction= Vector2(0,0)
var dashing=false
var walljump_amount = 2 #limit the amout of walljumps to two 



var velocity=Vector2(0,0)
var input_x=1
var face=true
func _physics_process(delta):
	
	velocity = move_and_slide(velocity,Vector2.UP)
	
	run(delta)
	jump()
	
	
	
	if health<=0:	
		get_tree().change_scene("res://Scenes/GameOver.tscn")
	

#running
func run(delta):
	
	if velocity.x>0:
		$AnimationTree.set("parameters/Idle/blend_position",input_x)
		$AnimationTree.set("parameters/Run/blend_position",input_x)
		$AnimationTree.set("parameters/JumpStart/blend_position",input_x)
		$AnimationTree.set("parameters/JumpLoop/blend_position",input_x)
		$AnimationTree.set("parameters/Wall/blend_position",input_x)
	elif velocity.x<0:
		$AnimationTree.set("parameters/Idle/blend_position",input_x)
		$AnimationTree.set("parameters/Run/blend_position",input_x)
		$AnimationTree.set("parameters/JumpStart/blend_position",input_x)
		$AnimationTree.set("parameters/JumpLoop/blend_position",input_x)
		$AnimationTree.set("parameters/Wall/blend_position",input_x)
	
	if Input.is_action_pressed("Right"):
		$AnimationTree.get("parameters/playback").travel("Run")
		face=true
		velocity.x=maxspeed
		input_x=1
	elif Input.is_action_pressed("Left"):
		$AnimationTree.get("parameters/playback").travel("Run")
		face=false
		velocity.x=-maxspeed
		input_x=-1
	else:
		$AnimationTree.get("parameters/playback").travel("Idle")
		
		

#jumping and 1 way platforms
func jump():
	if Input.is_action_pressed("Down"):
		set_collision_mask_bit(2,false)
	else:
		set_collision_mask_bit(2,true)
	if !is_on_floor():
		$AnimationTree.get("parameters/playback").travel("JumpLoop")

	if Input.is_action_just_pressed("Jump")&&is_on_floor():
			$JumpSound.play()
			velocity.y=-jumpForce
	if is_on_floor():
		walljump_amount=2

	velocity.x=lerp(velocity.x,0,0.2)

	if !is_on_floor()&&is_on_wall() &&(Input.is_action_pressed("Right")||Input.is_action_pressed("Left")):
		$AnimationTree.get("parameters/playback").travel("Wall")
		if velocity.y>=0:
			velocity.y=min(velocity.y+20,120)
		else:
			velocity.y+=gravity
	else:
			velocity.y+=gravity	
			
	if is_on_wall() && Input.is_action_pressed("Right")&&!is_on_floor()&&Input.is_action_just_pressed("Jump"):
		$JumpSound.play()
		velocity.y=-jumpForce
		velocity.x=-(maxspeed+500)
		walljump_amount = walljump_amount-1
		
		if walljump_amount <=0:
			Input.action_release("Right")
			walljump_amount =2
		
	elif is_on_wall() && Input.is_action_pressed("Left")&&!is_on_floor()&&Input.is_action_just_pressed("Jump"):
		$JumpSound.play()
		velocity.y=-jumpForce
		velocity.x=(maxspeed+500)
		walljump_amount = walljump_amount-1
		if walljump_amount <=0:
			Input.action_release("Left")
			walljump_amount = 2
	
	



#fallzone
func _on_Fallzone_body_entered(body):
	get_tree().change_scene("res://Scenes/GameOver.tscn")
	
#lvl change
func _on_lvl1_end_body_entered(body):
	get_tree().change_scene("res://BeforeLvl2.tscn")

#bounce after kill
func bounce():
	velocity.y=-jumpForce*0.6
	Input.action_release("Jump")
	
	

#coin
func add_coin():
	coins=coins+1

#heart
func add_health():
	health=health+2
	if health >=6:
		health=6

#hit
func hit(var eposx):
	$HitSound.play()
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
	health=health-1
	
func _on_Timer_timeout():
	set_modulate(Color(1,1,1,1))
	
#exit game
func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().quit()
	
