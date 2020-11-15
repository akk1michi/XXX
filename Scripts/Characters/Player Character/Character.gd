extends KinematicBody2D
var speed
const maxspeed=300
var gravity=50
var jumpForce=1000
var velocity=Vector2(0,0)
func _physics_process(delta):
	if Input.is_action_pressed("Right"):
		velocity.x=maxspeed
	if Input.is_action_pressed("Left"):
		velocity.x=-maxspeed
	
		
		
	velocity.y+=gravity
	if Input.is_action_pressed("Jump") and is_on_floor():
		velocity.y=-jumpForce
	velocity = move_and_slide(velocity,Vector2.UP)
	print(is_on_wall())
	#if is_on_floor()
		#velocity.y+=gravity
	velocity.x=lerp(velocity.x,0,0.2)
