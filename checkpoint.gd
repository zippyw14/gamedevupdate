extends Area3D

signal activated(position: Vector3)

var is_activated = false

func _ready():
	print("Checkpoint ready: ", name)
	connect("body_entered", Callable(self, "_on_body_entered"))

func _on_body_entered(body: Node) -> void:
	print("Body entered checkpoint: ", body.name)
	if body.name == "Player" and not is_activated:
		is_activated = true
		print("Checkpoint activated at: ", global_transform.origin)
		emit_signal("activated", global_transform.origin)
	elif body.name == "Player":
		print("Checkpoint already activated")
