# most code from a youtube tutorial by Heartbeast
extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -550
var motion = Vector2()
var double_jump = 0

var group = []
var added_friend = preload("res://Friends/Test_Friend.tscn")

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = false
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x + ACCELERATION,MAX_SPEED)
		$Sprite.flip_h = false

	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x - ACCELERATION , -MAX_SPEED)
		$Sprite.flip_h = true
		
	if Input.is_action_just_pressed("test_add_friend"):
		print (position)
		var friend_instance = added_friend.instance()
		add_child(friend_instance)
		#global_position.y += 128
		friend_instance.global_position.x = global_position.x - 64
		pass

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
