extends Node2D

var running = false

export var duration = 4.5
export var endpoint = Vector2(-320,0)

var originalPosition = Vector2()

func _ready():
	var BigDaddy = get_parent()
	BigDaddy.connect("RespawnHappened", self, "again")
	originalPosition = $TileMap.position
	$Tween.interpolate_property($TileMap,"position", Vector2(0,0),endpoint ,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)


func _on_Area2D_body_entered(body):
	if !running:
		running = true
		$Tween.start()
		print("yes")

func again():
	$Tween.stop_all()
	$TileMap.position = originalPosition
	running = false
	$Tween.interpolate_property($TileMap,"position", Vector2(0,0),endpoint ,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)
