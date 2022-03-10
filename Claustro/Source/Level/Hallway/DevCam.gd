extends KinematicBody

const MOVE_SPEED = 1
const MOUSE_SENS = 0.5

var camera_mode = false

onready var camera = $Camera

func _input(event):
	if event is InputEventMouseMotion and camera_mode:
		rotation_degrees.y -= MOUSE_SENS * event.relative.x
		camera.rotation_degrees.x -= MOUSE_SENS * event.relative.y
		camera.rotation_degrees.x = clamp(camera.rotation_degrees.x, -90, 90)


func _physics_process(delta):
	if camera_mode:
		var move_vec = Vector3()
		if Input.is_action_pressed("move_forwards"):
			move_vec.z -= 1
		if Input.is_action_pressed("move_backwards"):
			move_vec.z += 1
		if Input.is_action_pressed("move_left"):
			move_vec.x -= 1
		if Input.is_action_pressed("move_right"):
			move_vec.x += 1
		if Input.is_action_pressed("move_up"):
			move_vec.y -= 1
		if Input.is_action_pressed("move_down"):
			move_vec.y += 1
		move_vec = move_vec.normalized()
		move_vec = move_vec.rotated(Vector3(0, 1, 0), rotation.y)
		move_and_collide(move_vec * MOVE_SPEED * delta)
	
	if Input.is_action_just_pressed("toggle_camera"):
		camera_mode = !camera_mode
		if camera_mode:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
			$Camera.current = true
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			$Camera.current = false


