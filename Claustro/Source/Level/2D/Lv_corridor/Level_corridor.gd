extends Node2D

var party_member_name = ["",""]
var party_member_id = []
var party_location = 0

func _ready():
	party_member_id = GameManager.party_chr_id
	party_member_name[0] = GameManager.chr_basic_stat_list[party_member_id[0]].name
	party_member_name[1] = GameManager.chr_basic_stat_list[party_member_id[1]].name
	
	$Players/Player_left.current_chr_id = party_member_id[0]
	$Players/Player_right.current_chr_id = party_member_id[1]
	$Players/Player_left.player_type = "left"
	$Players/Player_right.player_type = "right"
	
