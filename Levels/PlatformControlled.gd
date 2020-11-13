extends Node2D

var PlayThis = "right"

export(Texture) var pressed
export(Texture) var default

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_PlatButton_body_entered(body):
	$AnimationPlayer.play(PlayThis)
	$PlatButton/Sprite.texture = pressed


func _on_PlatButton_body_exited(body):
	$AnimationPlayer.stop(false)
	$PlatButton/Sprite.texture = default


func _on_AnimationPlayer_animation_finished(anim_name):
	if PlayThis == "right":
		PlayThis = "left"
	else:
		PlayThis = "right"
	$AnimationPlayer.play(PlayThis)
