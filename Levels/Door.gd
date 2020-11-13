extends Node2D


export (Texture) var pressed
export (Texture) var default


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	$AnimationPlayer.play("open")
	$DoorButton/Sprite.texture = pressed


func _on_Area2D_body_exited(body):
	$AnimationPlayer.play_backwards("open")
	$DoorButton/Sprite.texture = default
