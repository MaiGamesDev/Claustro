extends Sprite

onready var tscn_bullet = preload("res://Source/Object/Bullet.tscn")
onready var tscn_boss = load("res://Source/Actor/Boss.tscn")

var max_hp = 10
var hp = max_hp

var ap = 0
var ap_persec = 10

func _process(delta):
	var ap_increase = ap_persec * delta
	if ap > 100:
		ap = 0
	ap += ap_increase
	
	$"../../".cur_boss_hp = hp
	$"../../".cur_boss_max_hp = max_hp
	$"../../".cur_boss_ap = ap
	
	if hp < 1 :
		die()

func die():
	var next_boss = $"../"
	var boss = tscn_boss.instance()
	boss.position = Vector2(0,0)
	next_boss.add_child(boss)
	$"../../".cur_boss_number += 1
	
	queue_free()
	

func _on_Tm_bullet_cool_timeout():
	var bullet = tscn_bullet.instance()
	bullet.position = $Pos_bullet.global_position
	get_tree().get_root().add_child(bullet)
	
	var bullet_cool = rand_range(1.0,1.8)
	
	$Tm_bullet_cool.wait_time = bullet_cool


func _on_Tm_bullet_cool2_timeout():
	var bullet2 = tscn_bullet.instance()
	bullet2.position = $Pos_bullet2.global_position
	get_tree().get_root().add_child(bullet2)
	
	var bullet_cool = rand_range(1.0,1.8)
	
	$Tm_bullet_cool2.wait_time = bullet_cool
