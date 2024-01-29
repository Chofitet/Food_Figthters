extends Control
@export var plate : String
var timer
func _ready():
	timer = $Timer
	timer.timeout.connect(StopTimer)

func ConnectItem(item):
	print(item)
	item.dialogue.connect(ShowDialogue)

func ShowDialogue(tex,Spawner):
	if Spawner.name == plate:
		visible = true
		$Label.text = tex
		timer.start()
	
func StopTimer():
	visible = false
	$Label.text = ""
