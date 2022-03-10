extends ColorRect


func _process(delta):
	if GameManager.party_chr_id[0] != null:
		$Character_icon.animation = GameManager.chr_basic_stat_list[GameManager.party_chr_id[0]].name
	else:
		$Character_icon.animation = "none"
		
	if GameManager.party_chr_id[1] != null:
		$Character_icon2.animation = GameManager.chr_basic_stat_list[GameManager.party_chr_id[1]].name
	else:
		$Character_icon2.animation = "none"
