extends Area2D

func _physics_process(delta):
	var enemies_in_range = get_overlapping_bodies()
	var closest_distance = 9999;
	var sp_pos = %ShootingPoint.global_position
	var pos_to_look = Vector2(0,0)
	
	
	if enemies_in_range.size() > 0:
		#Look for the closest one?
		for enemy in enemies_in_range:
			var en_pos = enemy.global_position
			if sp_pos.distance_to(en_pos) < closest_distance:
				closest_distance = sp_pos.distance_to(en_pos)
				pos_to_look = en_pos
		look_at(pos_to_look)

func shoot():
	if not get_node("/root/Game").defeated:
		const BULLET = preload("res://bullet.tscn")
		var new_bullet = BULLET.instantiate()
		new_bullet.global_position = %ShootingPoint.global_position
		new_bullet.global_rotation = %ShootingPoint.global_rotation
		%ShootingPoint.add_child(new_bullet)


func _on_timer_timeout():
	shoot()
	%Timer.wait_time = 1.0 / (get_node("/root/Game").difficulty_level)
