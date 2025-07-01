extends Node3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer
var anim_speed: float = 0.1

func _ready() -> void:
	if anim_player.has_animation("CINEMA_4D_Main"):
		anim_player.play("CINEMA_4D_Main")
	else:
		print("Animasi 'CINEMA_4D_Main' tidak ditemukan!")

func _process(delta: float) -> void:
	if anim_player.is_playing():
		anim_player.advance(delta * anim_speed)
