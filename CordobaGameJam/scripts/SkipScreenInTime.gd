extends Timer
var SceneToLoad = preload("res://scenes/main_menu.tscn")

func _ready():
	timeout.connect(SkipScreen)

func SkipScreen():
	get_tree().change_scene_to_packed(SceneToLoad)
