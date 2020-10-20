# most code from Heartbeast on youtube
extends Area2D


func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name.begins_with("Player"):
			body.got_a_friend()
			queue_free()

