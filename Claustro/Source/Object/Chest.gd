extends RigidBody

func open():
	$Animation.play("open")


func _on_CollsionDetecter_body_entered(body):
	open()
