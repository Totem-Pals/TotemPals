# most code from a youtube tutorial by Heartbeast
extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -550
var motion = Vector2()
var double_jump = 0

var identity = "Player"

export var current_height = 1


var group = []
var friends = []
onready var currentRectSize : Vector2 = $Sprite.get_rect().size

func _physics_process(_delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_just_pressed("switch"):
		if current_height > 2:
			var placeholder = get_child(0).position
			for i in range(current_height-2):
				get_child(i).position = get_child(i+1).position
			get_child(current_height-2).position = placeholder
	
	if Input.is_action_just_pressed("drop"):
		if current_height > 1:
			got_a_friend(0)
	
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
	
func got_a_friend(_change = 0):
	pass


func _on_FriendCollisionArea_area_entered(area):
	# Have to wait for current physics frame to be done.
	call_deferred("add_friend", area)


func add_friend(area):
	var friendSprite : Sprite = area.get_node("Sprite")
	var newFriend = load(area.totemVersion).instance()
	add_child(newFriend)
	friends.append(newFriend)
	
	move_child($FriendCollisionArea, get_child_count() - 1)
	
	newFriend.texture = friendSprite.texture
	# var friendAbility = area.get_ability()
	
	var friendSpriteRect : Rect2 = friendSprite.get_rect()
	newFriend.position.y = currentRectSize.y
	currentRectSize += friendSpriteRect.size
	
	update_collision_shapes()

	area.queue_free()

func update_collision_shapes():
	$FriendCollisionArea.position.y = currentRectSize.y - ($Sprite.texture.get_height() / 2)
	$CollisionShape2D.position.y = currentRectSize.y / 2 - ($Sprite.texture.get_height() / 2)
	
	$CollisionShape2D.shape.height = (currentRectSize.y) - (currentRectSize.x / 2)
