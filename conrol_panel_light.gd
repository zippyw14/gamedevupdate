extends SpotLight3D

var time_passed = 0.0
var flicker_interval = 0.1
var flicker_timer = 0.0
var flicker_on = true

func _process(delta: float) -> void:
	flicker_timer += delta
	time_passed += delta

	if time_passed > 1.0:
		flicker_interval = randf_range(0.05, 0.2)
		time_passed = 0

	if flicker_timer >= flicker_interval:
		flicker_timer = 0
		flicker_on = !flicker_on
		if flicker_on:
			light_energy = 10.0
		else:
			light_energy = 0.5
