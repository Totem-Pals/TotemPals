extends Node2D

export var length = 1
export var duration = 4
export var x_endpoint = 160
export var y_endpoint = 0

onready var child2D = $Node2D
onready var tile = $Node2D/TileMap
onready var tween = $Node2D/Tween
onready var tween2 = $Node2D/Tween2
onready var collision = $Node2D/CollisionShape2D

func _ready():
	for i in range(5 - length):
		tile.set_cellv(Vector2(4 - i, 0), -1)
	tile.update_bitmask_region(Vector2(0,0), Vector2(5,0))
	collision.position.x = 16 * length
	collision.shape.extents.x = 16 * length
	_on_Tween2_tween_all_completed()
	
func _on_Tween_tween_all_completed():
	tween2.interpolate_property(child2D, "position", Vector2(x_endpoint, y_endpoint), Vector2(0, 0), duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween2.start()
	
func _on_Tween2_tween_all_completed():
	tween.interpolate_property(child2D, "position", Vector2(0, 0), Vector2(x_endpoint, y_endpoint), duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
