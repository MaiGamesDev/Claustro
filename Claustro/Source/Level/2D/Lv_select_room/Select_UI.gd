extends Control


var current_chr_id = 0

func _process(delta):
	if Input.is_action_just_pressed("1"):
		_on_Button_pressed()
	if Input.is_action_just_pressed("2"):
		_on_Button2_pressed()
	if Input.is_action_just_pressed("3"):
		_on_Button3_pressed()

func _on_Button_pressed():
	current_chr_id = 0
	$Character_info.current_chr_id = 0
func _on_Button2_pressed():
	current_chr_id = 1
	$Character_info.current_chr_id = 1
func _on_Button3_pressed():
	current_chr_id = 2
	$Character_info.current_chr_id = 2
