# most code from Heartbeast on youtube
extends Area2D


func _physics_process(delta):
	var bodies = get_overlapping_bodies()
	for body in bodies:
		if body.name == "Player":
			print ("collide")
			pass

