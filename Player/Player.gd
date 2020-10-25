# most code from a youtube tutorial by Heartbeast
extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -550
const ABILITIES = {
	"double_jump": 1<<0,
	"glide": 1<<1
}
const friend_type = {
	"GreenPal.tscn": "double_jump",
	"RedPal.tscn": ""
}
var motion = Vector2()
var double_jump = 0

var identity = "Player"

export var num_friends = 0 setget ,get_num_friends

var has_ability = 0


var stack = []
var friends = []
onready var currentRectSize : Vector2 = $Sprite.get_rect().size

func _ready():
	update_collision_shapes()

func _physics_process(_delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_just_pressed("switch"):
		if self.num_friends > 2:
			var placeholder = get_child(0).position
			for i in range(num_friends - 2):
				get_child(i).position = get_child(i+1).position
			get_child(num_friends - 2).position = placeholder
	

	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION,MAX_SPEED)
		$Sprite.flip_h = false

	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION , -MAX_SPEED)
		$Sprite.flip_h = true
		
	

	else:

		friction = true
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
			if(has_ability&ABILITIES["double_jump"]):
				double_jump = 1
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:

		if Input.is_action_just_pressed("ui_up") and double_jump == 1:
			motion.y = JUMP_HEIGHT
			double_jump = 0
		
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	
	
	motion = move_and_slide(motion,UP)
	


func _input(event):
	if event.is_action_pressed("drop"):
		if self.num_friends > 0:
			drop_friend()



func _on_FriendCollisionArea_area_entered(area):
	# Have to wait for current physics frame to be done.
	call_deferred("add_friend", area)


func add_friend(area):
	var friendSprite : Sprite = area.get_node("Sprite")
	var newFriend = load(area.totemVersion).instance()
	add_child(newFriend)
	friends.append(newFriend)
	stack.append(friend_type[area.totemVersion.get_file()])
	
	newFriend.texture = friendSprite.texture

	
	var friendSpriteRect : Rect2 = friendSprite.get_rect()
	newFriend.position.y = (currentRectSize.y) + (friendSpriteRect.size.y / 2) - ($Sprite.get_rect().size.y / 2)
	
	update_collision_shapes()
	update_abilities(stack.back(), false)
	area.queue_free()

func update_rect_size():
	currentRectSize = $Sprite.get_rect().size
	for friend in friends:
		currentRectSize += friend.get_rect().size

func update_collision_shapes():
	update_rect_size()
	
	$FriendCollisionArea.position.y = currentRectSize.y - ($Sprite.texture.get_height() / 2)
	$CollisionShape2D.position.y = (currentRectSize.y / 2) - ($Sprite.texture.get_height() / 2)
	$CollisionShape2D.shape.height = currentRectSize.y - ($CollisionShape2D.shape.radius * 2)

func drop_friend():
	friends[friends.size() - 1].queue_free()
	friends.pop_back()
	update_abilities(stack.pop_back(), true)
	update_collision_shapes()

func get_num_friends() -> int:
	return friends.size()
	

func update_abilities(totem, drop):
	## For Testing Only to prevent totems in development from crashing
	if(totem == ""):
		return
	var ability_key = 0
	ability_key = ABILITIES[totem]
	if(self.get(totem)):
		set(totem, 0)
	if(drop):
		has_ability ^= ability_key
	else:
		has_ability |= ability_key
	
