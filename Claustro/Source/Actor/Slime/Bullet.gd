extends RigidBody

var velocity = Vector3(0,0,0)
var speed = 1.0

var damage = 1

func _ready():
	linear_velocity = velocity * speed


