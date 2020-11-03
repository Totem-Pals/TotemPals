extends Node2D


func _ready():
	pass # Replace with function body.
	
func _on_Area2D_body_entered(body):
	$RigidBody2D.set_deferred("mode", 0)


func _on_Area2D_body_exited(body):
	$RigidBody2D.set_deferred("mode", 1)
