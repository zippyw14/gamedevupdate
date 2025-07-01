extends Node3D

@export var speed := 2.0
@export var top_position := Vector3(0, 5, 0)
@export var bottom_position := Vector3(0, 0, 0)

var moving_up := false
var moving_down := false

func _ready():
	$Elevator1.body_entered.connect(_on_body_entered)
	$Elevator1.body_exited.connect(_on_body_exited)

func _process(delta):
	if moving_up:
		# Gunakan position bukan translation
		position = position.move_toward(top_position, speed * delta)
	elif moving_down:
		position = position.move_toward(bottom_position, speed * delta)

func _on_body_entered(body):
	if body.is_in_group("player"):
		moving_up = true
		moving_down = false

func _on_body_exited(body):
	if body.is_in_group("player"):
		moving_down = true
		moving_up = false
