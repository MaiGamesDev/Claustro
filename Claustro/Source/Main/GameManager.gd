extends Node

var dict_basic_stat_cat = {
	"name" : "cat",
	"maxHP" : 3,
	"DMG" : 40,
	"SPD" : 2
}
var dict_basic_stat_mouse = {
	"name" : "mouse",
	"maxHP" : 3,
	"DMG" : 30,
	"SPD" : 3
}
var dict_basic_stat_dog = {
	"name" : "dog",
	"maxHP" : 4,
	"DMG" : 40,
	"SPD" : 1
}
var chr_basic_stat_list = [
	dict_basic_stat_cat,
	dict_basic_stat_mouse,
	dict_basic_stat_dog
]

var party_chr_id = [
	null,null
]

#####

var dict_info_cat = {
	"name" : "김애옹",
	"career" : "고양이 마법사",
	"skil" : "강력한 폭발마법",
	"HP" : 3,
	"DMG" : 2,
	"SPD" : "보통",
	
	"sprite" : "cat"
}
var dict_info_mouse = {
	"name" : "강쥐",
	"career" : "쥐 사격수",
	"skil" : "재빠른 사격",
	"HP" : 3,
	"DMG" : 1,
	"SPD" : "보통",
	
	"sprite" : "mouse"
}
var dict_info_dog = {
	"name" : "개나리",
	"career" : "개 칼잡이",
	"skil" : "균형잡힌 베기",
	"HP" : 4,
	"DMG" : 2,
	"SPD" : "낮음",
	
	"sprite" : "dog"
}
var chr_info_dict_list = [
	dict_info_cat,
	dict_info_mouse,
	dict_info_dog
]



func change_level(scene_path):
	var level = get_tree().get_root().get_node("/root/Game/Level")
	for child in level.get_children():
		child.queue_free()
	
	var scene = scene_path.instance()	
	level.add_child(scene)

