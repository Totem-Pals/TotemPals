extends Area2D

export var Entry = true
export var PartnerLoc : NodePath
onready var teleportPosition = get_node(PartnerLoc).position
export var OneWay = true

func _ready():
	pass

func _on_Portal_body_entered(body):
	#32 is the rect size of the current main character
	if not body is KinematicBody2D:
		return
	
	var portal_offset = body.currentRectSize.y - 32
	if Entry:
		body.position = teleportPosition - Vector2(0, portal_offset)

func _on_Portal_body_exited(body):
	if !OneWay:
		if !Entry:
			Entry = true
		else:
			Entry = false

