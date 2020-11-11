extends Sprite

onready var Animate = $AnimationPlayer
var Thing_to_bounce = null

func woooosh():
	if Thing_to_bounce.is_in_group("Player"):
		Thing_to_bounce.motion.y = -1000

func _on_Area2D_body_entered(body):
	Thing_to_bounce = body
	Animate.play("Bounce")
	yield(Animate, "animation_finished")
	Animate.play("Bounce", -1, -4, true)
	woooosh()

func _on_Area2D_body_exited(_body):
	Thing_to_bounce = null
