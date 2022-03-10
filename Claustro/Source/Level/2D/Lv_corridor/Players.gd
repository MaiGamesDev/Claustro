extends Node2D

var party_member_name = ["",""]
var party_member_id = []

var tp = 0

func _ready():
	party_member_id = GameManager.party_chr_id
	party_member_name[0] = GameManager.chr_basic_stat_list[party_member_id[0]].name
	party_member_name[1] = GameManager.chr_basic_stat_list[party_member_id[1]].name
	
	$Player_left.current_chr_id = party_member_id[0]
	$Player_right.current_chr_id = party_member_id[1]
	$Player_left.player_type = "left"
	$Player_right.player_type = "right"
	
