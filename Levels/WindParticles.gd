extends Particles2D

export var WindLifeTime : int


# Called when the node enters the scene tree for the first time.
func _ready():
	self.lifetime = WindLifeTime

