extends Node3D

@export var arrow_scene: PackedScene
@onready var spawn_area: Area3D = $Area3D
@onready var timer: Timer = $Timer

func _ready():
	timer.timeout.connect(_on_timer_timeout)
	print("✅ ArrowSpawner siap")

func start_spawning():
	if timer.is_stopped():
		timer.start()
		print("🚀 Spawning panah dimulai")

func stop_spawning():
	timer.stop()
	print("🛑 Spawning panah dihentikan")

func _on_timer_timeout():
	if arrow_scene == null:
		push_error("❗ arrow_scene belum diassign di Inspector!")
		return

	var shape = spawn_area.get_node("CollisionShape3D").shape
	if shape == null:
		push_error("❗ Shape spawn area kosong!")
		return

	var extents = shape.extents
	var origin = spawn_area.global_transform.origin

	# Posisi spawn acak dalam volume Area3D
	var spawn_position = Vector3(
		origin.x + randf_range(-extents.x, extents.x),
		origin.y + extents.y,
		origin.z + randf_range(-extents.z, extents.z)
	)

	var arrow = arrow_scene.instantiate()
	arrow.global_transform.origin = spawn_position
	get_tree().current_scene.add_child(arrow)

	# Rotasi panah agar menghadap ke bawah
	arrow.rotation_degrees = Vector3(90, 0, 0)

	print("🏹 Spawn panah di:", spawn_position)
