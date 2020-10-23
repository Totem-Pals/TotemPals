# most code from a youtube tutorial by Heartbeast
extends KinematicBody2D

const UP = Vector2(0,-1)
const GRAVITY = 40
const ACCELERATION = 50
const MAX_SPEED = 550
const JUMP_HEIGHT = -900
var motion = Vector2()
var double_jump = 0

var identity = "Player"

export var next_evolution = 3
export var current_height = 1
onready var Evolve = load("res://Player/Player" + str(next_evolution) + ".tscn")
onready var Devolve = load("res://Player/Player" + str(current_height - 1) + ".tscn")



var group = []

func _physics_process(delta):
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
			got_a_friend(Devolve)
	
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
			double_jump = 0 # Set to 0 to disable double jump, or 1 to re-enable for testing purposes.
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:

		if Input.is_action_just_pressed("ui_up") and double_jump == 1:
			motion.y = JUMP_HEIGHT
			double_jump = 0
		
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	
	
	motion = move_and_slide(motion,UP)
	
func got_a_friend(change = Evolve):
	var evolve_instance = change.instance()
	get_parent().add_child(evolve_instance, true)
	evolve_instance.global_position = global_position
	queue_free()
