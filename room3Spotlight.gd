extends SpotLight3D

@export var fade_duration: float = 2

var timer: float = 0.0
var fading_out: bool = true
var original_energy: float = 1.0

func _ready() -> void:
	original_energy = light_energy

func _process(delta: float) -> void:
	timer += delta
	if fading_out:
		light_energy = lerp(original_energy, 0.0, timer / fade_duration)
	else:
		light_energy = lerp(0.0, original_energy, timer / fade_duration)

	if timer >= fade_duration:
		timer = 0.0
		fading_out = !fading_out
