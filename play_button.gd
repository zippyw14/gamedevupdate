extends Control
const WORLD_MANAGER = preload("res://world_manager.tscn")
const main_menu = preload("res://main_menu.tscn")

@onready var menu = $menu
@onready var word = $"../WorldEnvironment"
@onready var resume = $"."
@onready var save = $save
@onready var no = $save/no
@onready var yes = $save/yes
@onready var info = $info
@onready var key = $key

func _on_button_pressed() -> void:
	if menu:
		# Matikan menu dan BGM
		menu.visible = false
		# Tampilkan dan mainkan video
		menu.visible = true
		
	else:
		print("❌ Node load tidak ditemukan.")
		
func _on_back_pressed() -> void:
	if resume:
		menu.visible = false
		resume.visible = true
	else:
		print("❌ Node MainMenu tidak ditemukan.")

func _on_go_main_menu_pressed() -> void:
	get_tree().change_scene_to_packed(main_menu)


func _on_exit_to_desktop_pressed() -> void:
	get_tree().quit()
	

func _on_save_pressed() -> void:
	if save:
		menu.visible = false
		save.visible = true
	else:
		print("❌ Node save tidak ditemukan.")


func _on_yes_pressed() -> void:
	if no:
		save.visible = false
		menu.visible = true
	else:
		print("❌ Node save tidak ditemukan.")

func _on_no_pressed() -> void:
	if yes:
		save.visible = false
		menu.visible = true
	else:
		print("❌ Node save tidak ditemukan.")


func _on_info_pressed() -> void:
	if key:
		# Matikan menu dan BGM
		key.visible = false
		# Tampilkan dan mainkan video
		key.visible = true
		
	else:
		print("❌ Node load tidak ditemukan.")


func _on_back_to_menu_pressed() -> void:
	if resume:
		key.visible = false
		resume.visible = true
	else:
		print("❌ Node MainMenu tidak ditemukan.")
