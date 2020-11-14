# most code from a youtube tutorial by Heartbeast
extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION = 50
const GLIDE_SPEED = 120
const MAX_SPEED = 200
const JUMP_HEIGHT = -550
var abilities = {
	"double_jump": false,
	"glide": false,
	"strong": false,
	"shoots": false
}
const friend_type = {
	"GreenPal.tscn": "double_jump",
	"RedPal.tscn": "glide",
	"StrongPal.tscn": "strong",
	"GunPal.tscn": "shoots"
}
const friend_map = {
	"GreenPal.tscn": "res://Friends/NeutralFriend/GreenFriend.tscn",
	"RedPal.tscn": "res://Friends/NeutralFriend/RedFriend.tscn",
	"StrongPal.tscn": "res://Friends/NeutralFriend/StrongFriend.tscn",
	"GunPal.tscn": "res://Friends/NeutralFriend/GunFriend.tscn"
}
var motion = Vector2()
var double_jump = 0
var glide_speed = Vector2(0,GLIDE_SPEED) setget set_glide, get_glide
func set_glide(speed):
	glide_speed = speed
func get_glide():
	return glide_speed

var identity = "Player"

export var num_friends = 0 setget ,get_num_friends

var drop_timer = 0

var stack = []
var friends = []
onready var currentRectSize : Vector2 = $Sprite.get_rect().size

var lastCheckpoint = null


func _ready():
	update_collision_shapes()

func _physics_process(_delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION,MAX_SPEED)
		$Sprite.flip_h = false
		for friend in friends:
			friend.flip_h=false

	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION , -MAX_SPEED)
		$Sprite.flip_h = true
		for friend in friends:
			friend.flip_h=true
	else:
		friction = true
		
	if is_on_floor():
		if(has_ability("double_jump") and not double_jump):
				double_jump = 1
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			position.y -=10
			if(get_floor_velocity().y < 0):
				position.y -= 1
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if Input.is_action_just_pressed("ui_up") and double_jump == 1:
			motion.y = JUMP_HEIGHT
			double_jump = 0
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
		if has_ability("glide") and Input.is_action_pressed("ui_up"):
			if glide_speed.y < 0 or motion.y > 0:
				if(glide_speed.x):
					motion = glide_speed
				else:
					motion.y = glide_speed.y
				

	motion = move_and_slide(motion,UP)

func _input(event):
	if event.is_action_pressed("drop"):
		if self.num_friends > 0:
			drop_friend()
	if Input.is_action_just_pressed("switch"):
		if self.num_friends > 1:
			switch_friend()
	if Input.is_action_just_pressed("shoot"):
			shoot()
	if event.is_action_pressed("DEBUG_DIE"):
		on_death()


func _on_FriendCollisionArea_area_entered(area):
	# Have to wait for current physics frame to be done.
	if( OS.get_ticks_msec() - drop_timer > 500):
		call_deferred("add_friend", area)


func add_friend(area):
	var friendSprite : Sprite = area.get_node("Sprite")
	var newFriend = load(area.totemVersion).instance()
	add_child(newFriend)
	friends.append(newFriend)
	newFriend.flip_h = $Sprite.flip_h
	stack.append(friend_type[area.totemVersion.get_file()])
	newFriend.texture = friendSprite.texture
	var friendSpriteRect : Rect2 = friendSprite.get_rect()
	newFriend.position.y = (currentRectSize.y) + (friendSpriteRect.size.y / 2) - ($Sprite.get_rect().size.y / 2)
	update_collision_shapes()
	update_abilities(stack.back(), false)
	area.queue_free()

func load_friend(var friend_in):
	var friend = friend_in.duplicate()
	var friendSprite : Sprite = friend
	add_child(friend)
	friends.append(friend)
	stack.append(friend_type[friend.filename.get_file()])
	friend.texture = friendSprite.texture
	var friendSpriteRect : Rect2 = friendSprite.get_rect()
	friend.position.y = (currentRectSize.y) + (friendSpriteRect.size.y / 2) - ($Sprite.get_rect().size.y / 2)
	update_collision_shapes()
	update_abilities(stack.back(), false)
	
func update_rect_size():
	currentRectSize = $Sprite.get_rect().size
	for friend in friends:
		currentRectSize += friend.get_rect().size

func update_collision_shapes():
	update_rect_size()
	
	$FriendCollisionArea.position.y = currentRectSize.y - ($Sprite.texture.get_height() / 2)
	$CollisionShape2D.position.y = (currentRectSize.y / 2) - ($Sprite.texture.get_height() / 2)
	$CollisionShape2D.shape.height = currentRectSize.y - ($CollisionShape2D.shape.radius * 2)
	
	
	$SpikesArea/CollisionShape2D.position.y = (currentRectSize.y / 2) - ($Sprite.texture.get_height() / 2)
	$SpikesArea/CollisionShape2D.shape.height = currentRectSize.y - ($SpikesArea/CollisionShape2D.shape.radius * 2)

func drop_friend():
	friends[friends.size() - 1].queue_free()
	var back = friends.pop_back()
	update_abilities(stack.pop_back(), true)
	update_collision_shapes()
	var dropped_friend = load(friend_map[back.filename.get_file()])
	var friend = dropped_friend.instance()
	friend.position.x = self.position.x
	friend.position.y = self.position.y + currentRectSize.y
	drop_timer = OS.get_ticks_msec()
	
	var world = get_parent()
	world.add_child(friend)

func switch_friend():
	var top = friends.pop_front()
	var current_position = top.position.y
	for friend in friends:
		friend.position.y = current_position
		current_position += $Sprite.texture.get_height()
	top.position.y = current_position
	friends.push_back(top)
	var bottom_stack = stack.pop_front()
	stack.push_back(bottom_stack)
	
func get_num_friends() -> int:
	return friends.size()

func shoot():
	var bullet = load("res://Objects/Bullet.tscn")
	var b = bullet.instance()
	var position
	for friend in friends:
		if(friend.filename.get_file() ==  "GunPal.tscn"):
			get_parent().add_child(b)
			b.init($Sprite.flip_h)
			position = Vector2(self.position.x+5, self.position.y + friend.position.y)
			b.set_position(position)
	

func update_abilities(totem, drop):
	## For Testing Only to prevent totems in development from crashing
	if(totem == ""):
		return
	var ability_key = 0
	ability_key = abilities[totem]
	if(self.get(totem)):
		set(totem, 0)
	if(drop):
		abilities[totem] = false
	else:
		abilities[totem] = true

func has_ability(ability):
	if(abilities.has(ability)):
		return abilities[ability]

	print("Bad Ability Passed: "+ability)
	return false

func on_death():
	if lastCheckpoint == null:
		get_parent().reset()
		return
	
	lastCheckpoint.respawnPlayer()
	queue_free()

func _on_SpikesArea_body_entered(body):
	if !body.is_in_group("Bullet"):
		on_death()
