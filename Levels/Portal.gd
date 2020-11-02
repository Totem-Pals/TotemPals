extends Area2D

export var Entry = true
export var OneWay = true
export var PartnerLoc = Vector2(0,0)

func _ready():
	pass

func _on_Portal_body_entered(body):
	#32 is the rect size of the current main character
	var portal_offset = body.currentRectSize.y - 32
	if Entry:
		body.position = PartnerLoc - Vector2(0, portal_offset)

func _on_Portal_body_exited(body):
	if !OneWay:
		if !Entry:
			Entry = true
		else:
			Entry = false

