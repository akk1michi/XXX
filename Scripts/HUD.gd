extends CanvasLayer
var coins=0

func _ready():
	$Panel/Coins.text=String(coins)
	
func _physics_process(delta):
	if coins==3:
		get_tree().change_scene("res://Scenes/Lvl1.tscn")

func _on_coin_collected():
	coins=coins+1
	_ready()
