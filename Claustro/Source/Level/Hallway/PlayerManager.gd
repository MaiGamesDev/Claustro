extends Spatial

signal player1_hp_updated
signal player2_hp_updated
signal player_hurted

onready var player1_statusEffect = $Player1/AnimationTree/StatusEffect
onready var player2_statusEffect = $Player2/AnimationTree/StatusEffect

var player1_basic_hp = 10
var player1_max_hp = player1_basic_hp
var player1_hp = player1_basic_hp

var player2_basic_hp = 10
var player2_max_hp = player2_basic_hp
var player2_hp = player2_basic_hp

var can_move = false
var move_speed = 1


var ap = 100

func _ready():
	$Player1/Shield.hide()
	$Player2/Shield.hide()

func _process(delta):
	if Input.is_action_just_pressed("block_left"):
		$Player1/Shield.show()
	if Input.is_action_just_released("block_left"):
		$Player1/Shield.hide()
	if Input.is_action_just_pressed("block_right"):
		$Player2/Shield.show()
	if Input.is_action_just_released("block_right"):
		$Player2/Shield.hide()
		
	if Input.is_action_pressed("up"):
		if can_move:
			translation.z -= move_speed * delta
		

func hurt(player : int, damage : int):
	if player == 0:
		player1_statusEffect.play("hurt")
		player1_hp -= damage
		emit_signal("player1_hp_updated", player1_max_hp, player1_hp)
	else:
		player2_statusEffect.play("hurt")
		player2_hp -= damage
		emit_signal("player2_hp_updated", player2_max_hp, player2_hp)
	
func start_event(position):
	can_move = false
	global_transform.origin.x = position.x
	global_transform.origin.y = position.y

func _on_Player1_hurted(body):
	if !Input.is_action_pressed("block_left"):
		hurt(0, body.damage)
	body.queue_free()

func _on_Player2_hurted(body):
	if !Input.is_action_pressed("block_right"):
		hurt(1, body.damage)
	body.queue_free()



func _on_PlayerCollision_area_entered(area):
	if area is Event:
		start_event(area.global_transform.origin)


func _on_Enemy_died():
	can_move = true
