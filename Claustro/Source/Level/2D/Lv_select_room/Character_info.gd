extends Control


var current_chr_id = 0
var current_chr_info_dict


func _ready():
	pass
	
func _process(delta):
	current_chr_info_dict = GameManager.chr_info_dict_list[current_chr_id]
	set_info_box(current_chr_info_dict)
	
	if Input.is_action_just_pressed("ui_select"):
		_on_Choose_button_pressed()
	if Input.is_action_just_pressed("ESC"):
		_on_Reset_button_pressed()
		
func set_info_box(dict):
	$Name.text = dict.name
	$Career.text = dict.career
	$Skil.text = dict.skil
	$HP.text = "체력:" + String(dict.HP)
	$DMG.text = "공격:" + String(dict.DMG)
	$SPD.text = "속도:" + String(dict.SPD)
	
	$Character.animation = dict.sprite
	$Skil_icon.animation = dict.sprite
	
	rect_position.y = 80 + 70 * current_chr_id
	


func _on_Choose_button_pressed():
	var party_chr_id = GameManager.party_chr_id
	if party_chr_id[0] == null:
		party_chr_id[0] = current_chr_id
	
	elif party_chr_id[1] == null and party_chr_id[0] != current_chr_id:
		party_chr_id[1] = current_chr_id
	

func _on_Reset_button_pressed():
	GameManager.party_chr_id = [null,null]
