extends Sprite

var friends : Array = []

onready var playerObject = preload("res://Player/Player.tscn")

func _on_Area2D_area_entered(area):
	var player = area.get_parent()
	player.lastCheckpoint = self
	friends = player.friends
	
	self.modulate = Color.red
	call_deferred("disable")

func disable():
	$Area2D/CollisionShape2D.disabled = true

func respawnPlayer():
	var newPlayer = playerObject.instance()
	newPlayer.position = self.position
	get_parent().add_child(newPlayer)
	
	for friend in friends:
		newPlayer.load_friend(friend)
	
	newPlayer.lastCheckpoint = self
	#newPlayer.update_abilities()
	#newPlayer.update_collision_shapes()
