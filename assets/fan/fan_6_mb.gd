extends Node3D

@onready var anim_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	await get_tree().process_frame
	if anim_player.has_animation("CINEMA_4D_Main"):
		anim_player.play("CINEMA_4D_Main")
	else:
		print("Animasi 'CINEMA_4D_Main' tidak ditemukan!")
