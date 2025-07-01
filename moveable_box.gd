extends RigidBody3D

func _ready() -> void:
	# Kunci rotasi agar objek tidak berputar saat didorong atau ditarik (opsional)
	set_axis_lock(PhysicsServer3D.BODY_AXIS_ANGULAR_X, true)
	set_axis_lock(PhysicsServer3D.BODY_AXIS_ANGULAR_Y, true)
	set_axis_lock(PhysicsServer3D.BODY_AXIS_ANGULAR_Z, true)

func apply_push(force_direction: Vector3, force_magnitude: float) -> void:
	# Dorong objek ke arah tertentu
	apply_central_impulse(force_direction.normalized() * force_magnitude)

func apply_pull(puller_position: Vector3, pull_strength: float) -> void:
	# Tarik objek ke arah puller (misal player)
	var direction = (puller_position - global_position).normalized()
	apply_central_force(direction * pull_strength)
