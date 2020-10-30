extends Area2D

export var Entry = true
export var PartnerLoc = Vector2(0,0)

func _ready():
	pass

func _on_Portal_body_entered(body):
	#75 was the y rect size of the test main character
	var portal_offset = body.currentRectSize.y - 75
	if Entry:
		body.position = PartnerLoc - Vector2(0, portal_offset)

func _on_Portal_body_exited(body):
	if !Entry:
		Entry = true
	else:
		Entry = false

