extends Area3D

@onready var video_player = $"../VideoStreamPlayer"
var player_path = "/root/Main/Player"  # Ubah sesuai path player kamu
var player = null

func _ready():
	player = get_node(player_path)
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body == player:
		# Hentikan player
		if player.has_method("stop_movement"):
			player.stop_movement()
		elif "velocity" in player:
			player.velocity = Vector3.ZERO

		if player.has_method("set_process_input"):
			player.set_process_input(false)
		print("Terdeteksi: ", body.name)  # Cek ini tampil di Output
		# Putar video
		video_player.play()
