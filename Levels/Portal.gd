extends Area2D

export var Entry = true
export var PartnerLoc : NodePath
onready var teleportPosition = get_node(PartnerLoc).position

func _ready():
	pass

func _on_Portal_body_entered(body):
	if Entry:
		body.position = teleportPosition

func _on_Portal_body_exited(_body):
	Entry = !Entry

