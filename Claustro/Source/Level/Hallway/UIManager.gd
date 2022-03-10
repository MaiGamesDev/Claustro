extends Control

var current_turn = "P1"

signal turn_changed
signal enemy_turn_started
signal player_attacked

onready var Skill1_space = $BasicCommand/Skill/Container/Space
onready var Skill2_space = $BasicCommand/Skill/Container2/Space
onready var Skill3_space = $BasicCommand/Skill/Container3/Space
onready var Skill4_space = $BasicCommand/Skill/Container4/Space


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

