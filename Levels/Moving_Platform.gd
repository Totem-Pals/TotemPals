extends Node2D

export var length = 1
export var speed = 4
export var x_endpoint = 160
export var y_endpoint = 0

onready var child2D = $Node2D
onready var tile = $Node2D/TileMap
onready var tween = $Node2D/Tween
onready var tween2 = $Node2D/Tween2

func _ready():
	for i in range(5 - length):
		tile.set_cellv(Vector2(4 - i, 0), -1)
	tile.update_bitmask_region(Vector2(0,0), Vector2(5,0))
	_on_Tween2_tween_all_completed()
	
func _on_Tween_tween_all_completed():
	tween2.interpolate_property(child2D, "position", Vector2(x_endpoint, y_endpoint), Vector2(0, 0), speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween2.start()
	
func _on_Tween2_tween_all_completed():
	tween.interpolate_property(child2D, "position", Vector2(0, 0), Vector2(x_endpoint, y_endpoint), speed,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
