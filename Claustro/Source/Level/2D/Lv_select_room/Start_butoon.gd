extends TouchScreenButton

onready var tscn_level_corridor = preload("res://Source/Level/Lv_corridor/Level_corridor.tscn")

func _process(delta):
	if GameManager.party_chr_id[0] == null or GameManager.party_chr_id[1] == null:
		visible = false
	else:
		visible = true
		
		
	if Input.is_action_just_pressed("ui_accept") and visible == true:
		_on_Start_butoon_pressed()


func _on_Start_butoon_pressed():
	GameManager.change_level(tscn_level_corridor)
