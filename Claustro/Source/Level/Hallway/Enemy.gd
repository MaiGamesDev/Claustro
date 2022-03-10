extends RigidBody

signal turn_finished
signal enemy_died

var is_dead = false

onready var animationState = $AnimationTree.get("parameters/playback")

func _ready():
	$HealthBar.texture = $HealthBar/Viewport.get_texture()
	
			
func shoot(is_toward_P1 : bool):
	var player
	if is_toward_P1:
		player = $"../../../Player/Player1"
	else:
		player = $"../../../Player/Player2"
	
	var look = player.global_transform.origin - $ShootPos.global_transform.origin
	look.y = 0
	var bullet = load("res://Source/Actor/Slime/Bullet.tscn").instance()
	bullet.velocity = look
	bullet.translation = $ShootPos.translation
	add_child(bullet)
	
func turn_end():
	emit_signal("turn_finished")

func hurt(dmg : float):
	$AnimationTree/StatusEffect.play("hurt")
	$HealthBar/Viewport/ProgressBar.value -= dmg
	
	if $HealthBar/Viewport/ProgressBar.value < 1 and !is_dead:
		animationState.travel("die")
		is_dead = true

func die():
	$Sprite.hide()
	spawn_reward()
	animationState.stop()
	
	emit_signal("enemy_died")

func spawn_reward():
	var chest = load("res://Source/Object/Chest.tscn").instance()
	chest.translation = $ChestSpawnPos.translation
	add_child(chest)


func _on_enemy_turn_started():
	animationState.travel("attack")


func _on_player_attacked(dmg):
	hurt(dmg)
