extends Node

const MAIN_MENU = preload("res://scenes/main_menu.tscn")

func _input(event: InputEvent) -> void:
	if Input.is_action_just_released("escape"):
		get_tree().change_scene_to_packed(MAIN_MENU)
