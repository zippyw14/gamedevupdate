extends CharacterBody3D

@export var patrol_distance: float = 5
@export var speed: float = 1
@export var collision_avoidance_distance: float = 1

@onready var start_position: Vector3 = global_position
@onready var player_node: Node3D = $WorldEnvironment/Player
@onready var raycast_to_player: RayCast3D = $CollisionShape3D/AnimationLibrary_Godot_Standard/RayCast3D
@onready var guard_visual: Node3D = $CollisionShape3D/AnimationLibrary_Godot_Standard
@onready var guard_anim: AnimationPlayer = guard_visual.get_node("AnimationPlayer")

var direction: int = 1
var player_detected: bool = false
var look_timer: float = 0.0
var look_duration: float = 5
var is_looking: bool = false
var is_dead: bool = false
var death_logged: bool = false

func _ready():
	guard_anim.play("Walk")
	_update_facing()



func _physics_process(delta: float) -> void:
	if is_dead:
		velocity = Vector3.ZERO
		move_and_slide()
		if not death_logged:
			death_logged = true
			print("Guard has died.")
		return
		

	_check_player_detection()
	_check_collision_avoidance()

	if player_detected:
		velocity = Vector3.ZERO
		move_and_slide()
		guard_anim.play("Idle")
		_face_idle()
		return

	if is_looking:
		look_timer -= delta
		if look_timer <= 0:
			is_looking = false
			guard_anim.play("Walk")
			_update_facing()
		velocity = Vector3.ZERO
		move_and_slide()
		_face_idle()
		return

	velocity.x = direction * speed
	velocity.y = 0
	velocity.z = 0
	move_and_slide()

	if abs(global_position.x - start_position.x) >= patrol_distance:
		velocity.x = 0
		move_and_slide()
		is_looking = true
		look_timer = look_duration
		guard_anim.play("Idle")
		_face_idle()
		direction *= -1
		_update_facing()

	if not is_looking and velocity.x != 0:
		guard_anim.play("Walk")
		_update_facing()

func _check_player_detection():
	if raycast_to_player.is_colliding():
		var hit = raycast_to_player.get_collider()
		player_detected = (hit == player_node)
	else:
		player_detected = false

func _check_collision_avoidance():
	if raycast_to_player.is_colliding():
		var collision_point = raycast_to_player.get_collision_point()
		var dist = global_position.distance_to(collision_point)
		if dist <= collision_avoidance_distance:
			direction *= -1
			_update_facing()

func _update_facing():
	guard_visual.rotation_degrees.y = 90 if direction > 0 else -90

func _face_idle():
	guard_visual.rotation_degrees.y = 0

func die():
	if not is_dead:
		is_dead = true
		guard_anim.play("Die")
