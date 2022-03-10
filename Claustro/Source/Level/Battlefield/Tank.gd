extends VehicleBody

var horse_power = 90
var accel_speed = 20

var steer_angle = deg2rad(20)
var steer_speed = 1

var brake_power = 40
var brake_speed = 40

func _ready():
	$Turret/gun/FirePoint/ShootEffect.show()

func _physics_process(delta):
	
	#가속
	var throt_input = int(Input.is_action_pressed("move_backwards")) - int(Input.is_action_pressed("move_forwards"))
	engine_force = lerp(engine_force, throt_input*horse_power, accel_speed*delta)
	
	#방향전환 
	var steer_input = int(Input.is_action_pressed("move_left")) - int(Input.is_action_pressed("move_right"))
	steering = lerp_angle(steering, steer_input*steer_angle, steer_speed*delta)

	#브레이크
	var brake_input = int(Input.is_action_pressed("brake"))
	brake = lerp(brake, brake_input*brake_power, brake_speed*delta)

func _process(delta):
	if Input.is_mouse_button_pressed(BUTTON_LEFT):
		shoot()
		
func shoot():
	$AnimationPlayer.play("shoot")
