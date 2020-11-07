extends Node2D


func _ready():
	pass # Replace with function body.
	
func _on_Area2D_body_entered(body):

	if(body.is_in_group("Player")):
		if !body.check_ability("strong"):
			$RigidBody2D.set_deferred("mode", 1)



func _on_Area2D_body_exited(body):
	print("out")
	$RigidBody2D.set_deferred("mode", 2)


func _on_Area2D2_body_entered(body):
	$RigidBody2D.set_deferred("mode", 1)

func _on_Area2D2_body_exited(body):
	$RigidBody2D.set_deferred("mode", 2)
