extends RayCast3D

func _process(delta: float) -> void:
	if is_colliding():
		var collider = get_collider()
		var distance = global_position.distance_to(get_collision_point())
		#print("Detected object:", collider, " | Distance:", distance)
	#else:
		##print("No object detected")
