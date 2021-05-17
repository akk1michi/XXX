extends Node2D

var score = 0

func _ready():
	$Score.text= String(global.score)
