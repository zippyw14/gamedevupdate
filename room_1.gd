extends Node3D

@onready var button = $Button
@onready var box = $Box
@onready var button_light = get_node_or_null("../ButtonLight")  # sesuaikan path

func _ready():
	if button_light == null:
		print("ERROR: ButtonLight tidak ditemukan!")
		return
	button.connect("button_pressed", Callable(self, "_drop_box"))
	box.freeze = true

func _drop_box():
	if button_light == null:
		print("ERROR: ButtonLight belum siap!")
		return
	print("Menjatuhkan kotak!")
	box.freeze = false
	button_light.light_color = Color(0, 1, 0)  # ubah warna lampu ke hijau
