extends Control

var current_turn = "P1"

signal turn_changed
signal enemy_turn_started
signal player_attacked

export(String, FILE, "*.json") var skill_data_file

onready var Skill1 = $BasicCommand/Skill/Container
onready var Skill2 = $BasicCommand/Skill/Container2
onready var Skill3 = $BasicCommand/Skill/Container3
onready var Skill4 = $BasicCommand/Skill/Container4

onready var Skill1_space = Skill1.get_node("Space")
onready var Skill2_space = Skill2.get_node("Space")
onready var Skill3_space = Skill3.get_node("Space")
onready var Skill4_space = Skill4.get_node("Space")

onready var Skill1_sprite = Skill1.get_node("Skill1/Sprite")
onready var Skill2_sprite = Skill2.get_node("Skill2/Sprite")
onready var Skill3_sprite = Skill3.get_node("Skill3/Sprite")
onready var Skill4_sprite = Skill4.get_node("Skill4/Sprite")
var skill_sprite_array = [
	Skill1_sprite,
	Skill2_sprite,
	Skill3_sprite,
	Skill4_sprite
]

var current_skill = 0

func _ready():
	update_card_image()

func change_turn(turn : String):
	current_turn = turn
	emit_signal("turn_changed",current_turn)
	
	match current_turn:
		"P1":
			pass
		"P2":
			pass
		"E1":
			emit_signal("enemy_turn_started")
			
func next_turn():
	match current_turn:
		"P1":
			change_turn("P2")
		"P2":
			change_turn("E1")
		"E1":
			change_turn("P1")

func update_current_card(number : int,is_entered : bool):
	var spaces = [
		Skill1_space,
		Skill2_space,
		Skill3_space,
		Skill4_space
	]
	var space = spaces[number]
	var tween = space.get_node("../Tween")
	
	var value
	if is_entered:
		value = 0
	else:
		value = 30
		
	tween.interpolate_property(space, "rect_min_size:y", space.rect_min_size.y, value, 1.0, tween.TRANS_QUINT, tween.EASE_OUT)
	tween.start()
	
func update_card_image():
	# Read the skill data
	var file = File.new()
	if file.file_exists(skill_data_file):
		file.open(skill_data_file, File.READ)
		current_skill = file.get_var()
		file.close()
	else:
		current_skill = 0
		
	#경로 정의
	var path = "res://Art/UI/Skill_card/cat/sc_magicball.png"
	
	for i in 4:
		skill_sprite_array[i].texture = load
	
func update_hp(player : int, max_value : int, value: int):
	if player == 0:
		var text = str(value) + "/" + str(max_value)
		$State/VBoxContainer/HBoxContainer/PlayerHp1.text = text
	else:
		var text = str(value) + "/" + str(max_value)
		$State/VBoxContainer/HBoxContainer/PlayerHp2.text = text
		

func _on_Skill1_mouse_entered():
	update_current_card(0,true)
func _on_Skill2_mouse_entered():
	update_current_card(1,true)
func _on_Skill3_mouse_entered():
	update_current_card(2,true)
func _on_Skill4_mouse_entered():
	update_current_card(3,true)
func _on_Skill1_mouse_exited():
	update_current_card(0,false)
func _on_Skill2_mouse_exited():
	update_current_card(1,false)
func _on_Skill3_mouse_exited():
	update_current_card(2,false)
func _on_Skill4_mouse_exited():
	update_current_card(3,false)


func _on_Skill1_pressed():
	emit_signal("player_attacked",1)
	next_turn()
func _on_Skill2_pressed():
	next_turn()
func _on_Skill3_pressed():
	next_turn()
func _on_Skill4_pressed():
	next_turn()

func _on_Enemy_turn_finished():
	next_turn()


func _on_player1_hp_updated(max_hp : int, hp : int):
	update_hp(0,max_hp,hp)

func _on_player2_hp_updated(max_hp : int, hp : int):
	update_hp(1,max_hp,hp)

