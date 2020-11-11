extends Node2D

export var length = 3
export(float) var duration = 4
export var x_endpoint = 160
export var y_endpoint = 0
export var idle_at_end = 0.5
export var auto = true

var follow = Vector2.ZERO
var running = false

var OriginalPosition = Vector2()

onready var child2D = $Node2D
onready var tile = $Node2D/TileMap
onready var tween = $Node2D/Tween
onready var tween2 = $Node2D/Tween2
onready var collision = $Node2D/CollisionShape2D
onready var switch = $Node2D/Area2D/CollisionShape2D

func _ready():
	for i in range(5 - length):
		tile.set_cellv(Vector2(4 - i, 0), -1)
	tile.update_bitmask_region(Vector2(0,0), Vector2(5,0))
	collision.position.x = 16 * length
	collision.shape.extents.x = 16 * length
	switch.position.x = 16 * length
	switch.shape.extents.x = 16 * length - 5
	if auto:
		running = true
		_on_Tween2_tween_all_completed()
	else:
		var BigDaddy = get_parent()
		BigDaddy.connect("RespawnHappened", self, "again")
		OriginalPosition = child2D.position
	
func _on_Tween_tween_all_completed():
	tween2.interpolate_property(child2D, "position", Vector2(x_endpoint, y_endpoint), Vector2(0, 0), duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, idle_at_end)
	tween2.start()
	
func _on_Tween2_tween_all_completed():
	tween.interpolate_property(child2D, "position", Vector2(0, 0), Vector2(x_endpoint, y_endpoint), duration,
		Tween.TRANS_LINEAR, Tween.EASE_IN_OUT, idle_at_end)
	tween.start()
	
#func _physics_process(delta):
#	child2D.position = child2D.position.linear_interpolate(follow, 0.075)


func _on_Area2D_body_entered(_body):
	if !running:
		_on_Tween2_tween_all_completed()
		running = true
		
func again():
	tween.call_deferred("stop", child2D)
	tween2.call_deferred("stop", child2D)
	child2D.position = OriginalPosition
	running = false

	

