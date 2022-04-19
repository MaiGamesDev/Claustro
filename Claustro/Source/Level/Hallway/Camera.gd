extends Camera

var origin_pos = translation
onready var animationState = $AnimationTree.get("parameters/playback")

func rotate_camera(value : Vector3):
	$Tween.interpolate_property(self, "rotation_degrees", rotation_degrees, value, 2.0,$Tween.TRANS_QUINT, $Tween.EASE_OUT)
	$Tween.start()
	
func move_camera(value : Vector3):
	$Tween2.interpolate_property(self, "translation", translation, value, 2.0,$Tween.TRANS_QUINT, $Tween.EASE_OUT)
	$Tween2.start()

func _input(event):
	if event is InputEventKey:
		if Input.is_action_just_pressed("1"):
			animationState.travel("left_side")
		if Input.is_action_just_pressed("2"):
			animationState.travel("right_side")
		if Input.is_action_just_pressed("3"):
			animationState.travel("enemy_side")


func _on_UI_turn_changed(turn):
	match turn:
		"PLAYER":
			animationState.travel("left_side")
		"ENEMY":
			animationState.travel("enemy_side")
