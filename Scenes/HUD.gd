extends CanvasLayer

var coins = 0
var health =0

func _ready():
	health = $"../Character".health
	$Heart.play("Full heart")
	$Heart2.play("Full heart")
	$Heart3.play("Full heart")
	$Score.text= String(coins)
	
func _physics_process(delta):
	health = $"../Character".health	
	if (health==6):
		$Heart.play("Full heart")
		$Heart2.play("Full heart")
		$Heart3.play("Full heart")
	elif (health==5):
		$Heart.play("Full heart")
		$Heart2.play("Full heart")
		$Heart3.play("Half heart")
	elif (health==4):
		$Heart.play("Full heart")
		$Heart2.play("Full heart")
		$Heart3.play("Empty heart")
	elif (health==3):
		$Heart.play("Full heart")
		$Heart2.play("Half heart")
		$Heart3.play("Empty heart")
	elif (health==2):
		$Heart.play("Full heart")
		$Heart2.play("Empty heart")
		$Heart3.play("Empty heart")
	elif (health==1):
		$Heart.play("Half heart")
		$Heart2.play("Empty heart")
		$Heart3.play("Empty heart")
		
	


func _on_coin_collected():
	coins = coins + 10
	_ready()

func _on_damage_taken():
	health = health - 1
	_ready()
