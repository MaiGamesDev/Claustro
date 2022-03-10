extends Control


var player_maxHP
var player_curHP

var player2_maxHP
var player2_curHP

func _process(delta):
	set_player_UI()
	set_boss_UI()

func set_player_UI():
	var player_left = $"../../Players/Player_left"
	var player_right = $"../../Players/Player_right"
	var player_left_ap = player_left.ap
	var player_right_ap = player_right.ap
	var player_tp = $"../../Players".tp
	
	player_maxHP = player_left.max_hp
	player2_maxHP = player_right.max_hp
	player_curHP = player_left.current_hp
	player2_curHP = player_right.current_hp
	
	# HP 값 
	$Player_left_hp/hp.text = String(player_curHP) + "/" + String(player_maxHP)
	$Player_right_hp/hp.text = String(player2_curHP) + "/" + String(player2_maxHP)
	
	$Player_left_hp.max_value = player_maxHP
	$Player_left_hp.value = player_curHP
	$Player_right_hp.max_value = player2_maxHP
	$Player_right_hp.value = player2_curHP
	
	# AP 값
	$Player_left_ap.value = player_left_ap
	$Player_right_ap.value = player_right_ap
	
	# TP 값 
	$Player_tp.value = player_tp
	if player_tp > 99:
		$Player_tp/Tp_max.visible = true
	else:
		$Player_tp/Tp_max.visible = false

func set_boss_UI():
	var boss = $"../../Enemies"
	var boss_hp = boss.cur_boss_hp
	var boss_max_hp = boss.cur_boss_max_hp
	var boss_ap = boss.cur_boss_ap
	
	$Boss_hp.max_value = boss_max_hp
	$Boss_hp.value = boss_hp
	
	$Boss_ap.value = boss_ap
