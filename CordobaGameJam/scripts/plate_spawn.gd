extends Marker2D

@onready var new_plate : PackedScene = preload("res://scenes/plate.tscn")

func _ready() -> void:
	generator_plate()

func generator_plate() -> void:
	var  other_plate = new_plate.instantiate()
	add_child(other_plate)
