extends Sprite

const SPEED = 400

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

func _process(delta):
	move(delta)
	check_range(delta)
	
func move(delta):
	global_position += velocity * delta
	
func check_range(delta):
	if(velocity.x * delta > 3000):
		queue_free()
