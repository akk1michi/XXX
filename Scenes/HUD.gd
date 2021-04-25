extends CanvasLayer

var coins = 0
var health = 3

func _ready():
	$Score.text= String(coins)
	
	
 


func _on_coin_collected():
	coins = coins + 10
	_ready()

func _on_damage_taken():
	health = health - 1
	_ready()
