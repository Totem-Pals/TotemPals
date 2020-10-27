extends Node2D

onready var Solid = $Sprite/StaticBody2D/CollisionShape2D
onready var Animate = $Sprite/AnimationPlayer

func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(body):
	Animate.play("collapse")
