extends RayCast3D

@onready var player: Node3D = $"../../../../../Player"

func _ready():
	enabled = player != null

func _process(delta):
	if is_colliding():
		var collider = get_collider()
		if collider == null:
			return

		if collider == player and player.has_method("die"):
			player.die()
