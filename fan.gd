extends Node3D

@onready var anim_player: AnimationPlayer = $Sketchfab_Scene6/AnimationPlayer

func _ready() -> void:
	await get_tree().process_frame
	if anim_player.has_animation("CINEMA_4D_Main"):
		var anim = anim_player.get_animation("CINEMA_4D_Main")
		anim.loop = true
		anim_player.play("CINEMA_4D_Main")
	else:
		print("Animasi tidak ditemukan")
