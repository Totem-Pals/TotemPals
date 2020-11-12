extends Sprite

var friends : Array = []

export(Texture) var activated
onready var playerObject = preload("res://Player/Player.tscn")

signal reset_objects

func _ready():
	var BigDaddy = get_parent()
	self.connect("reset_objects", BigDaddy, "listeningForRespawn")

func _on_Area2D_area_entered(area):
	var player = area.get_parent()
	if(player.is_in_group("Player")):
		player.lastCheckpoint = self
		friends = player.friends
		self.texture = activated
		call_deferred("disable")

func disable():
	$Area2D/CollisionShape2D.disabled = true

func respawnPlayer():
	emit_signal("reset_objects")
	var newPlayer = playerObject.instance()
	
	newPlayer.position = self.position - Vector2(0,32)
	get_parent().add_child(newPlayer)
	
	for friend in friends:
		newPlayer.load_friend(friend)
	
	friends = newPlayer.friends
	
	newPlayer.lastCheckpoint = self
	#newPlayer.update_abilities()
	#newPlayer.update_collision_shapes()
