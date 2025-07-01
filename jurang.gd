# water.gd
extends Area3D

# Fungsi ini akan dipanggil saat ada body (seperti CharacterBody3D, RigidBody3D, StaticBody3D)
# memasuki area deteksi air ini.
func _on_body_entered(body: Node3D):
	# DEBUG: Cetak nama objek yang masuk untuk memastikan deteksi
	print("Objek terdeteksi masuk jurang: ", body.name)

	# Periksa apakah objek yang masuk adalah 'Player' atau bagian dari grup 'player'
	if body.name == "Player" or body.is_in_group("player"):
		print("Player masuk jurang! Memanggil fungsi 'die()'...")
		# Cek apakah objek player memiliki fungsi 'die()' sebelum memanggilnya
		if body.has_method("die"):
			body.die() # Panggil fungsi die() pada player
		else:
			# Jika player tidak punya fungsi die(), cetak peringatan
			print("❗Peringatan: Node '", body.name, "' (diduga Player) tidak memiliki fungsi 'die()'.")

# Ini adalah fungsi bawaan Godot yang dipanggil saat node siap
func _ready():
	# Hubungkan sinyal 'body_entered' dari Area3D ini ke fungsi '_on_body_entered'
	# Ini penting agar script bisa bereaksi ketika ada objek masuk area air.
	body_entered.connect(_on_body_entered)
	print("Script jurang.gd siap. Menunggu objek memasuki area...")
