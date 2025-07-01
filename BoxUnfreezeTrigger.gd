# BoxUnfreezeTrigger.gd
extends Area3D

@export var target_box: RigidBody3D # Hubungkan di Inspector

var has_triggered: bool = false

func _ready():
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D):
	# Deteksi Player dan pastikan hanya trigger sekali
	if (body.name == "Player" or body.is_in_group("player")) and not has_triggered:
		if target_box != null:
			if target_box.has_method("unfreeze_box"):
				target_box.unfreeze_box()
				has_triggered = true
				# Opsional: self.monitoring = false // untuk menonaktifkan trigger setelah dipakai
			else:
				# Fallback jika BoxBehavior.gd tidak ada
				target_box.freeze = false
				target_box.sleeping = false
				has_triggered = true
		else:
			print("❗Error: target_box belum terhubung.")
