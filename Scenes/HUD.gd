extends CanvasLayer

var coins = 0

func _ready():
	$Score.text= String(coins)
	
	
 


func _on_coin_collected():
	coins = coins + 10
	_ready()

