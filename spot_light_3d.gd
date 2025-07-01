extends SpotLight3D

var blink_timer := 0.0
var tick_interval := 0.3
var delay_at_tick_5 := 1.0
var is_on := true
var tick := 1

func _process(delta: float) -> void:
	blink_timer += delta
	if tick == 5:
		if blink_timer >= delay_at_tick_5:
			tick = 6
			blink_timer = 0.0
	else:
		if blink_timer >= tick_interval:
			tick += 1
			blink_timer = 0.0
	
	match tick:
		1, 2, 3:
			light_energy = 50
		4:
			light_energy = 25
		5:
			light_energy = 10
		6:
			light_energy = 0
			tick = 1
