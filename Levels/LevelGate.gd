# most code from Heartbeast on youtube
extends Area2D

export var Next_scene = "res://Levels/World3.tscn"

# This should be a signal
#func _physics_process(_delta):
#	var bodies = get_overlapping_bodies()
#	for body in bodies:
#		if body.name.begins_with("Player"):
#			get_tree().reload_current_scene()
#
func _on_LevelGate_body_entered(body):
	get_tree().change_scene(Next_scene)

