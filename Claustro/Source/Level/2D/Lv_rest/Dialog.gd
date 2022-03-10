extends Control
var origin_pos
var text_number = 0
var is_left_side = true

var tscn_Dialog_text = preload("res://Source/Level/Lv_rest/Dialog_text.tscn")

var dialog_string_list = [
	"안녕",
	"내이름은 김애옹이야",
	"고급마법학 자격증까지 가진",
	"마법의 천재지",
	"",
	"어썸",
	"하네용",
	"",
	"그른가??",
	"",
	"전",
	"검 휘두르는",
	"미친 개임",
	"ㄷㄷㄷㄷㄷ",
	"",
	"ㄷㄷㄷㄷㄷㄷ"
]

func _ready():
	origin_pos = rect_global_position.y

func _process(delta):
	if Input.is_action_just_pressed("ui_select"):
		var text_space = 18
		
		var text = tscn_Dialog_text.instance()
		if dialog_string_list[text_number] == "":
			is_left_side = !is_left_side
			text.text_bg_visble = false
			
		if is_left_side:
			text.bbcode_text = "[color=blue]" + dialog_string_list[text_number] + "[/color]"
		else:
			text.bbcode_text = "[color=red]" + "[right]" + dialog_string_list[text_number] + " [/right]" + "[/color]"
		text.rect_position.y = text_space * text_number
		add_child(text)
		
		rect_position.y += -text_space
		text_number += 1
