extends Area2D

var AffectedObject = null

func _physics_process(delta):
	# will refactor using signal
	if AffectedObject:
		AffectedObject.motion.y = -300

func _on_Vertical_Wind_body_entered(body):
	AffectedObject = body

func _on_Vertical_Wind_body_exited(body):
	AffectedObject = null
