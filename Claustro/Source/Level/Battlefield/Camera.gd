extends SpringArm

onready var turret = $"../Turret"

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	$Camera.add_exception(get_parent())

func _input(event):
	if Input.is_action_just_pressed("ESC"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	
	if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
		if event is InputEventMouseMotion:
			rotation_degrees.x = clamp(rotation_degrees.x-event.relative.y*0.1,-45,0)
			rotation_degrees.y -= event.relative.x*0.1
			turret.rotation_degrees.y = rotation_degrees.y
			
