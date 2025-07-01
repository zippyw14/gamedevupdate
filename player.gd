extends CharacterBody3D

const WALK_SPEED = 12
const SPRINT_SPEED = 15
const JUMP_VELOCITY = 18
const GRAVITY = -30
const PUSH_FORCE = 100
const PULL_FORCE = 40
const MAX_PULL_DISTANCE = 64


@onready var anim: AnimationPlayer = $CollisionShape3D/AnimationLibrary_Godot_Standard.get_node("AnimationPlayer")
@onready var model: Node3D = $CollisionShape3D/AnimationLibrary_Godot_Standard
@onready var raycast: RayCast3D = $CollisionShape3D/AnimationLibrary_Godot_Standard/RayCast3D

var was_on_floor = true
var is_pushing = false
var is_pulling = false
var pull_body: RigidBody3D = null

var is_dead = false
var can_move = true

func die():
	if is_dead:
		return
	is_dead = true
	can_move = false
	anim.play("Death01")
	print("Player mati!")
	await get_tree().create_timer(2.5).timeout
	print("Respawn atau reload scene di sini")
	get_tree().reload_current_scene()

func _physics_process(delta: float) -> void:
	if is_dead:
		return

	if not is_on_floor():
		velocity.y += GRAVITY * delta
	else:
		velocity.y = 0

	if Input.is_action_just_pressed("ui_accept") and is_on_floor() and can_move:
		var jump_force := JUMP_VELOCITY  # deklarasi variabel dengan :=
		if Input.is_action_pressed("sprint"):
			jump_force += 4
		velocity.y = jump_force
		anim.play("Jump_Start")

	if raycast.is_colliding():
		var body = raycast.get_collider()
		var collision_point = raycast.get_collision_point()
		var dist = global_transform.origin.distance_to(collision_point)
		if Input.is_action_just_pressed("pull") and can_move:
			if body is RigidBody3D and dist <= MAX_PULL_DISTANCE:
				is_pulling = true
				pull_body = body

	if Input.is_action_just_released("pull"):
		is_pulling = false
		pull_body = null

	var move_input = 0
	if not is_pulling and can_move:
		if Input.is_action_pressed("ui_left"):
			move_input = -1
		elif Input.is_action_pressed("ui_right"):
			move_input = 1

	var is_sprinting = Input.is_action_pressed("sprint")
	var speed = WALK_SPEED
	if is_sprinting:
		speed = SPRINT_SPEED

	if is_pulling and pull_body and can_move:
		velocity.x = 0
		velocity.z = 0
		var facing_direction = sign(model.rotation_degrees.y)
		if facing_direction > 0:
			if Input.is_action_pressed("ui_left"):
				var pull_vec = Vector3(-1, 0, 0)
				pull_body.global_translate(pull_vec * PULL_FORCE * delta)
				global_translate(pull_vec * WALK_SPEED * delta)
		elif facing_direction < 0:
			if Input.is_action_pressed("ui_right"):
				var pull_vec = Vector3(1, 0, 0)
				pull_body.global_translate(pull_vec * PULL_FORCE * delta)
				global_translate(pull_vec * WALK_SPEED * delta)
	else:
		velocity.x = move_input * speed
		velocity.z = 0
		if move_input != 0 and can_move:
			model.rotation_degrees.y = -90 if move_input < 0 else 90

	move_and_slide()

	is_pushing = false
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		if body is RigidBody3D:
			var push_direction = collision.get_normal() * -1
			var push_velocity = push_direction * PUSH_FORCE * delta
			body.apply_impulse(push_velocity, collision.get_position() - body.global_position)
			is_pushing = true

	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		var body = collision.get_collider()
		if body and body.has_method("is_in_group") and body.is_in_group("deadly"):
			var normal = collision.get_normal()
			if normal.y < -0.5:
				die()


	if is_on_floor():
		if not was_on_floor:
			anim.play("Jump_Land")
		elif is_pulling and (Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right")):
			anim.play("Push")
		elif is_pushing:
			anim.play("Push")
		elif move_input == 0:
			anim.play("Idle")
		elif is_sprinting:
			anim.play("Sprint")
		else:
			anim.play("Jog_Fwd")

	was_on_floor = is_on_floor()
