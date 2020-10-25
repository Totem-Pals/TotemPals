extends Area2D

export var Entry = true
export var PartnerLoc = Vector2(0,0)

func _ready():
	pass

func _on_Portal_body_entered(body):
	if Entry:
		body.position = PartnerLoc

func _on_Portal_body_exited(body):
	if !Entry:
		Entry = true
	else:
		Entry = false

