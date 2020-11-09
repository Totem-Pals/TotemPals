extends Area2D

const wind_speed = -300

func _physics_process(_delta):
	return

func _on_Vertical_Wind_body_entered(body):
	if(body.is_in_group("Player")):
			body.glide_speed = wind_speed

func _on_Vertical_Wind_body_exited(body):
	if(body.is_in_group("Player")):
		body.glide_speed =body.GLIDE_SPEED
