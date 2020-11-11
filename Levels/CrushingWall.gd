extends Node2D

var running = false

export var duration = 4.5
export var endpoint = Vector2(-320,0)

onready var originalPosition = $TileMap.position

func _ready():
	$TileMap.position = originalPosition
	$Tween.stop_all()
	$Tween.interpolate_property($TileMap,"position", Vector2(0,0),endpoint ,duration,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT)


func _on_Area2D_body_entered(body):
	if !running:
		running = true
		$Tween.start()

