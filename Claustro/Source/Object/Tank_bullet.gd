extends RigidBody


var velocity = Basis().x
var speed = 1

func _ready():
	linear_velocity = velocity * speed
	

func _on_Hitbox_body_entered(body):
	print("bullet colided")
	queue_free()
