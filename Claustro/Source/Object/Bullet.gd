
extends RigidBody2D


func _ready():
	linear_velocity = Vector2(0,80)
	

func _on_Hitbox_area_entered(area):
	if area is Player:
		yield(get_tree(), "idle_frame")
		queue_free()
