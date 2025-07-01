extends Area3D

signal activated(position)

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("activated", global_position)
		print("check")
