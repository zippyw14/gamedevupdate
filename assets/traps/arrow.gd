extends Area3D

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))
	print("🎯 Arrow area ready!")

func _on_body_entered(body: Node3D):
	print("💥 Arrow collided with: ", body.name)

	if body.name == "Player" or body.is_in_group("player"):
		if body.has_method("die"):
			print("☠️ Player terkena panah!")
			body.die()
		else:
			print("❗ Player tidak memiliki fungsi die()!")
