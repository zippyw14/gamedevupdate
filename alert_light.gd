extends SpotLight3D

var blink_on = true
var blink_interval = 0.5  # detik

func _ready():
	var timer = Timer.new()
	timer.wait_time = blink_interval
	timer.one_shot = false
	timer.autostart = true
	add_child(timer)
	timer.connect("timeout", Callable(self, "_on_blink_timeout"))

func _on_blink_timeout():
	blink_on = !blink_on
	if blink_on:
		light_energy = 5.0  # lampu nyala
	else:
		light_energy = 0.0  # lampu mati
