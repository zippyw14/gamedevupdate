extends Camera3D

var shake_strength := 0.0
var shake_decay := 1.5
var noise := FastNoiseLite.new()
var noise_time := 0.0
var shake_speed := 8.0

@onready var original_local_position := position

func _ready():
	noise.seed = randi()
	noise.noise_type = FastNoiseLite.TYPE_SIMPLEX
	noise.frequency = 1.0
	original_local_position = position

func add_shake(amount: float):
	shake_strength = max(shake_strength, amount)

func _process(delta):
	if shake_strength > 0.0:
		shake_strength = max(shake_strength - delta * shake_decay, 0.0)
		noise_time += delta * shake_speed

		var offset = Vector3(
			noise.get_noise_2d(noise_time, 0),
			noise.get_noise_2d(0, noise_time),
			noise.get_noise_2d(noise_time, noise_time)
		) * shake_strength * 0.15

		position = original_local_position + offset
	else:
		position = original_local_position
