extends OmniLight3D

var flicker_timer := 0.0
var flicker_interval := 0.05  # Waktu antar kedipan
var base_energy := 3.0        # Nilai energy dasar lampu
var flicker_range := 1.5      # Seberapa besar variasi kedipan

func _ready() -> void:
	# Atur nilai awal energi lampu
	light_energy = base_energy

func _process(delta: float) -> void:
	flicker_timer -= delta
	if flicker_timer <= 0.0:
		flicker_timer = flicker_interval
		var random_flicker = randf_range(-flicker_range, flicker_range)
		light_energy = clamp(base_energy + random_flicker, 0.0, 10.0)
