extends Node2D

var PlayThis = "right"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_PlatButton_body_entered(body):
	$AnimationPlayer.play(PlayThis)


func _on_PlatButton_body_exited(body):
	$AnimationPlayer.stop(false)


func _on_AnimationPlayer_animation_finished(anim_name):
	if PlayThis == "right":
		PlayThis = "left"
	else:
		PlayThis = "right"
	$AnimationPlayer.play(PlayThis)
