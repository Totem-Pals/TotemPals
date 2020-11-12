extends Area2D

const wind_speed = 300
export var shapeExtents = Vector2(153,360)

func _physics_process(_delta):
	return
	
func _ready():
	$CollisionShape2D.shape.extents = shapeExtents

func _on_Horizontal_Wind_body_entered(body):
	if(body.is_in_group("Player")):
		if(rotation_degrees < 180):
			body.glide_speed.x = wind_speed
		else:
			body.glide_speed.x = -wind_speed


func _on_Horizontal_Wind_body_exited(body):
	if(body.is_in_group("Player")):
		body.glide_speed.x = 0
