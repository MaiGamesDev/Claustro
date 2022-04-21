extends Control

var current_turn = "PLAYER"

signal turn_changed
signal enemy_turn_started
signal player_attacked

export(String, FILE, "*.json") var skill_data_file
export(String, FILE, "*.json") var party_data_file
export(String, FILE, "*.json") var skill_info_file

onready var Skill1 = $BasicCommand/Skill/Skill1
onready var Skill2 = $BasicCommand/Skill/Skill2
onready var Skill3 = $BasicCommand/Skill/Skill3
onready var Skill4 = $BasicCommand/Skill/Skill4


onready var Skill1_sprite = Skill1.get_node("Skill/Sprite")
onready var Skill2_sprite = Skill2.get_node("Skill/Sprite")
onready var Skill3_sprite = Skill3.get_node("Skill/Sprite")
onready var Skill4_sprite = Skill4.get_node("Skill/Sprite")

onready var Skill1_label = Skill1.get_node("Skill/Label")
onready var Skill2_label = Skill2.get_node("Skill/Label")
onready var Skill3_label = Skill3.get_node("Skill/Label")
onready var Skill4_label = Skill4.get_node("Skill/Label")

var skill_info = 0

var current_skill = 0
var current_party = 0

func _ready():
	update_card_image()

func change_turn(turn : String):
	current_turn = turn
	emit_signal("turn_changed",current_turn)
	
	match current_turn:
		"PLAYER":
			pass
		"ENEMY":
			emit_signal("enemy_turn_started")
			
func next_turn():
	match current_turn:
		"PLAYER":
			change_turn("ENEMY")
			update_card_image()
		"ENEMY":
			change_turn("PLAYER")
			update_card_image()

func update_card_image():
	load_skill_data()
	load_party_data()
	load_skill_info()
	
	var current_chr
	var skill_array = ["","","",""]
	if current_turn == "PLAYER":
		current_chr = current_party.player1
		skill_array = [
			current_skill.player1_skill_1,
			current_skill.player1_skill_2,
			current_skill.player1_skill_3,
			current_skill.player1_skill_4
		]
	else:
		return
	
	var skill_sprite_array = [
		Skill1_sprite,
		Skill2_sprite,
		Skill3_sprite,
		Skill4_sprite
	]
	var skill_label_array = [
		Skill1_label,
		Skill2_label,
		Skill3_label,
		Skill4_label
	]
	for i in 4:
		print(skill_sprite_array[i].name)
		var path = "res://Art/UI/Skill_card/"+ current_chr + "/sc_" + skill_array[i] +".png"
		var texture = load(path)
		skill_sprite_array[i].texture = texture
		skill_label_array[i].text = skill_array[i]
		
func update_hp(player : int, max_value : int, value: int):
	if player == 0:
		var text = str(value) + "/" + str(max_value)
		$State/VBoxContainer/HBoxContainer/PlayerHp1.text = text
	else:
		var text = str(value) + "/" + str(max_value)
		$State/VBoxContainer/HBoxContainer/PlayerHp2.text = text
		
func load_skill_data():
	# skill data 불러오기
	var file = File.new()
	if not file.file_exists(skill_data_file):
		print("ERROR : can't find skill_data_file")
		return
	file.open(skill_data_file, File.READ)
	current_skill = parse_json(file.get_as_text())
	file.close()
	
func load_party_data():
	# party data 불러오기
	var file = File.new()
	if not file.file_exists(party_data_file):
		print("ERROR : can't find party_data_file")
		return
	file.open(party_data_file, File.READ)
	current_party = parse_json(file.get_as_text())
	file.close()
	
func load_skill_info():
	# party data 불러오기
	var file = File.new()
	if not file.file_exists(skill_info_file):
		print("ERROR : can't find party_data_file")
		return
	file.open(skill_info_file, File.READ)
	skill_info = parse_json(file.get_as_text())
	file.close()
	
	
		
func _on_Enemy_turn_finished():
	next_turn()

func _on_player1_hp_updated(max_hp : int, hp : int):
	update_hp(0,max_hp,hp)

func _on_player2_hp_updated(max_hp : int, hp : int):
	update_hp(1,max_hp,hp)

func _on_Skill1_pressed():
	emit_signal("player_attacked",1)
func _on_Skill2_pressed():
	pass
func _on_Skill3_pressed():
	pass
func _on_Skill4_pressed():
	pass
func _on_TurnEnd_pressed():
	next_turn()
