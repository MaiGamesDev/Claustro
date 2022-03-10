class_name Player
extends Area2D

var current_chr_name
var current_chr_id
var player_type

#스탯
var max_hp
var current_hp
var basic_dmg
var basic_spd

var dmg
var spd

var state = ""

var ap = 0



func _ready():
	
	yield(get_tree(), "idle_frame")
	current_chr_name = GameManager.chr_basic_stat_list[current_chr_id].name
	max_hp = GameManager.chr_basic_stat_list[current_chr_id].maxHP
	basic_dmg = GameManager.chr_basic_stat_list[current_chr_id].DMG
	basic_spd = GameManager.chr_basic_stat_list[current_chr_id].SPD
	dmg = basic_dmg
	spd = basic_spd
	current_hp = max_hp
	
	if player_type == "right":
		$Body.scale.x = -1
	
	$Body.animation = current_chr_name
	
func _process(delta):
	
	$State.text = state
	if state == "block":
		$Block_shape.visible = true
	else:
		$Block_shape.visible = false
		
	if current_hp < 1:
		die()
	
	# AP 관리
	var boss = get_node("../../Enemies/Pos_boss").get_child(0)
	var spd_multilier = 6
	var block_multiplier = 0.33
	var ap_persec = 10 + spd * spd_multilier
	
	if ap > 100:
		$Animation.play("attack")
		boss.hp -= dmg
		ap = 0
	elif state != "block":
		ap += ap_persec * delta
	else:
		ap += ap_persec * block_multiplier * delta 
		
	key_input()
	
func die():
	ap = 0
	visible = false
	set_process(false)
	
func key_input():
	
	if player_type == "left" and Input.is_action_just_pressed("block_left"):
		_on_Block_button_pressed()
	if player_type == "right" and Input.is_action_just_pressed("block_right"):
		_on_Block_button_pressed()
	if player_type == "left" and Input.is_action_just_released("block_left"):
		_on_Block_button_released()
	if player_type == "right" and Input.is_action_just_released("block_right"):
		_on_Block_button_released()
		
	if Input.is_action_just_pressed("backstep"):
		_on_Backstep_button_pressed()
		
		
func _on_Player_area_entered(area):
	if area is Bullet:
		var tp_increase = 2
		if state == "block":
			$"../".tp += tp_increase
		else:
			$Animation.play("hurt")
			
			var hurt_dmg = 1
			current_hp = clamp(current_hp - hurt_dmg, 0, 100)
			$"../".tp += tp_increase * 2


func _on_Block_button_pressed():
	if state != "backstep":
		state = "block"

func _on_Block_button_released():
	state = ""

func _on_Backstep_button_pressed():
	state = "backstep"


