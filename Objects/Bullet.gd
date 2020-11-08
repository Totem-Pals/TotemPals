extends KinematicBody2D

const SPEED = -400

var velocity = Vector2(SPEED, 0)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func init(x,y,flip):
	$Sprite.position.x = x
	$Sprite.position.y = y
	$Sprite.flip_h = flip
	if(flip):
		velocity = Vector2(SPEED, 0)
	else:
		velocity = Vector2(SPEED*-1, 0)

func _physics_process(delta):
	var hit = move_and_collide(velocity * delta)
	if hit:
		queue_free()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
