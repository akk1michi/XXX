extends ParallaxLayer

var xpos = 0
var xps=Vector2(xpos,0)

func _ready():
	$Timer.start()

func _on_Timer_timeout():
	set_position(xps)
	xpos = xpos+10
	
