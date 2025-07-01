extends Control  # Script ini dipasang di node root utama

const WORLD_MANAGER = preload("res://world_manager.tscn")

@onready var video_intro = $Videointro
@onready var video_ui = $Videobackround
@onready var menu_ui = $MarginContainer
@onready var bgm_player = $AudioStreamPlayer  # tambahkan ini

func _on_new_game_button_pressed() -> void:
	if video_intro:
		# Matikan menu dan BGM
		menu_ui.visible = false
		bgm_player.stop()
		video_ui.stop()
		# Tampilkan dan mainkan video
		video_intro.visible = true
		video_intro.play()
	else:
		print("❌ Node VideoIntro tidak ditemukan.")

func _on_videointro_finished() -> void:
	get_tree().change_scene_to_packed(WORLD_MANAGER)

func _on_quite_button_pressed() -> void:
	get_tree().quit()
