extends StaticBody2D

func _ready():
	pass # Replace with function body.


func _process(delta):
	
	var bodies = $Area2D.get_overlapping_bodies()
	if bodies:
		print ("collide")
	pass
