extends Area3D

signal button_pressed

func _ready():
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body):
	if body.name == "Player":
		print("Tombol dipencet oleh Player")
		emit_signal("button_pressed")
