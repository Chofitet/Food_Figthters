class_name MainMenu
extends Control

@onready var start: Button = $Menu/Start
@onready var credit: Button = $Menu/Credit
@onready var tutorial: Button = $Menu/Tutorial
@onready var start_level : PackedScene = preload("res://scenes/main.tscn")
@onready var exit: Button = $Menu/Exit
@onready var close: Button = $Tutorial/Close
@onready var next: Button = $Tutorial/Next
@onready var back: Button = $Tutorial/Back
@onready var close_credit: Button = $Credit/Close



func _ready() -> void:
	start.button_down.connect(on_start_pressed)
	exit.button_down.connect(on_exit_pressed)
	tutorial.button_down.connect(on_tutorial_pressed)
	close.button_down.connect(on_close_tutorial)
	next.button_down.connect(on_next_paper_tutorial)
	back.button_down.connect(on_back_paper_tutorial)
	credit.button_down.connect(on_credit)
	close_credit.button_down.connect(on_close_credit)
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)

func on_exit_pressed() -> void:
	get_tree().quit()

func on_tutorial_pressed() -> void:
	$Menu.visible = false
	$Tutorial.visible = true

func on_close_tutorial() -> void:
	$Tutorial.visible = false
	$Menu.visible = true

func on_next_paper_tutorial() -> void:
	$Tutorial/PaperOne.visible = false
	$Tutorial/PaperTwo.visible = true
	$Tutorial/Next.visible = false
	$Tutorial/Back.visible = true

func on_back_paper_tutorial() -> void:
	$Tutorial/PaperOne.visible = true
	$Tutorial/PaperTwo.visible = false
	$Tutorial/Next.visible = true
	$Tutorial/Back.visible = false

func on_credit() -> void:
	$Credit.visible = true

func on_close_credit() -> void:
	$Credit.visible = false
