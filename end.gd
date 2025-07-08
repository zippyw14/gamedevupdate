extends Area3D

@onready var video_player = $Control/VideoStreamPlayer  # akses video di bawah node ini

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":  # ganti nama sesuai node player kamu jika perlu
		print("Player masuk area akhir.")

		# Coba hentikan pergerakan player
		if body.has_method("stop_movement"):
			body.stop_movement()
		elif "velocity" in body:
			body.velocity = Vector3.ZERO

		# Nonaktifkan input (opsional)
		if body.has_method("set_process_input"):
			body.set_process_input(false)

		# Putar video ending
		video_player.play()

func _on_video_stream_player_finished() -> void:
	get_tree().change_scene_to_file("res://main_menu.tscn")
