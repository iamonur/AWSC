extends Node2D

var score = 0
var defeated = false
var difficulty_level = 0
var mobs_spawned = 0

func _ready():
	%Score.text = str(score)
	difficulty_level = 1

func spawn_mob():
	if not defeated:
		var new_mob = preload("res://mob.tscn").instantiate()
		%PathFollow2D.progress_ratio = randf()
		new_mob.global_position = %PathFollow2D.global_position
		add_child(new_mob)
		mobs_spawned += 1


func _on_timer_timeout():
	spawn_mob()
	%Score.text = str(score)
	%Mobs_Spawned.text = str(mobs_spawned)
	%Alive.text = str(mobs_spawned - score)
	difficulty_level = score / 10
	if difficulty_level == 0:
		difficulty_level = 1
	%Timer.wait_time = 1.0/difficulty_level

func _on_player_health_depleted():
	%GameOver.visible = true
	defeated = true
	%EndScore.text = str(score)

func _on_button_pressed():
	defeated = false
	get_tree().reload_current_scene()


func _on_tree_timer_timeout():
	if not defeated:
		var new_tree = preload("res://pine_tree.tscn").instantiate()
		%PathFollow2D.progress_ratio = randf()
		new_tree.global_position = %PathFollow2D.global_position
		add_child(new_tree)
