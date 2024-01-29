extends Control
var _timer
var SceneToLoad1 = preload("res://ganador_jugador_1.tscn")
var SceneToLoad2 = preload("res://ganador_jugador_2.tscn")
@export var client1 : Area2D
@export var client2 : Area2D
var winer
func _ready():
	_timer = $Timer
	_timer.timeout.connect(finishGame)

func _process(delta):
	$Label.text = "%d:%02d" % [floor($Timer.time_left / 60), int($Timer.time_left) % 60]


func finishGame():
	if client1.Points > client2.Points:
		get_tree().change_scene_to_packed(SceneToLoad1)
	elif client2.Points > client1.Points:
		get_tree().change_scene_to_packed(SceneToLoad2)
