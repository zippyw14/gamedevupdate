extends StaticBody3D

@export var speed := 7

var bottom_position := Vector3.ZERO
var top_position := Vector3.ZERO
var current_velocity := Vector3.ZERO
var player_on_lift: CharacterBody3D = null
var activated := false

func _ready():
	bottom_position = position - Vector3(0, 200, 0)
	top_position = position
	$Elevator1.body_entered.connect(_on_body_entered)


func _process(delta):
	if activated:
		var target_position = position.move_toward(bottom_position, speed * delta)
		current_velocity = (target_position - position) / delta
		position = target_position


		if player_on_lift and player_on_lift.is_inside_tree():
			player_on_lift.global_position += current_velocity * delta

		if position.distance_to(bottom_position) < 0.01:
			activated = false

func _on_body_entered(body):
	if body.name == "Player" and not activated:
		player_on_lift = body
		activated = true
