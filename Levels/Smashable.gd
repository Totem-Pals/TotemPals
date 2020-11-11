extends Node2D

onready var Solid = $Sprite/StaticBody2D/CollisionShape2D
onready var Animate = $Sprite/AnimationPlayer

func _ready():
	pass # Replace with function body.


func _on_Area2D_body_entered(_body):
	if(_body.is_in_group("Player")):
		print(_body.motion.y)
		if(_body.has_ability("strong") and Input.is_action_pressed("ui_down") and _body.motion.y > 60):
			Animate.play("crumble")
			self.queue_free()
		
