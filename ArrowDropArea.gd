extends Area3D

@onready var spawner: Node = $ArrowSpawner

func _ready():
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)
	print("🎯 Arrow area ready!")

func _on_body_entered(body: Node3D):
	if body.name == "Player" or body.is_in_group("player"):
		if spawner != null:
			print("👣 Player masuk ke area panah!")
			spawner.start_spawning()
		else:
			print("❌ Spawner tidak ditemukan!")

func _on_body_exited(body: Node3D):
	if body.name == "Player" or body.is_in_group("player"):
		if spawner != null:
			print("🚶 Player keluar dari area panah.")
			spawner.stop_spawning()
