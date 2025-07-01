extends Node3D

@onready var kiri = $Kiri
@onready var kanan = $Kanan
@onready var area_kiri = $AreaKiri
@onready var area_kanan = $AreaKanan
@onready var timer_kiri = $TimerKiri
@onready var timer_kanan = $TimerKanan
@onready var anim_player = $AnimationPlayer

var kiri_jatuh = false
var kanan_jatuh = false

func _ready():
 if area_kiri:
  area_kiri.body_entered.connect(_on_area_kiri_entered)
 else:
  print("❗AreaKiri tidak ditemukan")

 if area_kanan:
  area_kanan.body_entered.connect(_on_area_kanan_entered)
 else:
  print("❗AreaKanan tidak ditemukan")

 if timer_kiri:
  timer_kiri.timeout.connect(_on_timer_kiri_timeout)
 if timer_kanan:
  timer_kanan.timeout.connect(_on_timer_kanan_timeout)

# Player menyentuh bagian kiri jembatan
func _on_area_kiri_entered(body):
 if body.name == "Player" and not kiri_jatuh:
  kiri_jatuh = true
  if anim_player.has_animation("GoyangKiri"):
   anim_player.play("GoyangKiri")
  timer_kiri.start()

# Player menyentuh bagian kanan jembatan
func _on_area_kanan_entered(body):
 if body.name == "Player" and not kanan_jatuh:
  kanan_jatuh = true
  if anim_player.has_animation("GoyangKanan"):
   anim_player.play("GoyangKanan")
  timer_kanan.start()

# Timer habis → jatuhkan bagian kiri jembatan
func _on_timer_kiri_timeout():
 if kiri:
  jatuhkan_bagian(kiri, Vector3(0, 0, randf_range(-4.0, -6.0)))

  # Nonaktifkan collider agar Player bisa jatuh
  var col = kiri.get_node("CollisionShape3D")
  if col:
   col.disabled = true
   print("Collider kiri dimatikan")

  kiri.visible = false
  kiri.set_deferred("disabled", true)

# Timer habis → jatuhkan bagian kanan jembatan
func _on_timer_kanan_timeout():
 if kanan:
  jatuhkan_bagian(kanan, Vector3(0, 0, randf_range(4.0, 6.0)))

  var col = kanan.get_node("CollisionShape3D")
  if col:
   col.disabled = true
   print("Collider kanan dimatikan")

  kanan.visible = false
  kanan.set_deferred("disabled", true)

# Membuat bagian jembatan jatuh ke bawah dengan gaya natural
func jatuhkan_bagian(static_body: StaticBody3D, angular_velocity: Vector3):
 if static_body == null:
  return

 var new_rigid = RigidBody3D.new()
 new_rigid.transform = static_body.global_transform

 var mesh_node = static_body.get_node("MeshInstance3D")
 var shape_node = static_body.get_node("CollisionShape3D")
 var mesh = null
 var shape = null

 if mesh_node:
  mesh = mesh_node.mesh

 if shape_node:
  shape = shape_node.shape

 if mesh == null or shape == null:
  print("❗Mesh atau CollisionShape tidak ditemukan di:", static_body.name)
  return

 var mesh_instance = MeshInstance3D.new()
 mesh_instance.mesh = mesh
 new_rigid.add_child(mesh_instance)

 var collider = CollisionShape3D.new()
 collider.shape = shape
 new_rigid.add_child(collider)

 new_rigid.mass = 2.0
 new_rigid.angular_velocity = angular_velocity
 new_rigid.gravity_scale = 1.2

 get_parent().add_child(new_rigid)
