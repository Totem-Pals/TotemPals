extends Node2D


func _ready():
	pass # Replace with function body.
	
func _on_Area2D_body_entered(body):
	print("in")
	$RigidBody2D.set_deferred("mode", 2)


func _on_Area2D_body_exited(body):
	print("out")
	$RigidBody2D.set_deferred("mode", 1)
