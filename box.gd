extends RigidBody3D

@onready var head_detector = $HeadDetector

func _ready():
	head_detector.connect("body_entered", _on_head_hit)

func _on_head_hit(body):
	print("Terdeteksi benturan dengan:", body.name)
	if body.name == "Player" or body.is_in_group("player"):
		print("Mengenai Player!")
		if body.has_method("die"):
			body.die()
