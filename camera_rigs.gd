extends Node3D

var zoom_target := 1.0
var zoom_speed := 2.0

@onready var camera := $Camera3D

func _process(delta):
	# Interpolasi skala zoom (di Z axis) secara smooth
	var current_z = position.z
	position.z = lerp(current_z, zoom_target, delta * zoom_speed)
