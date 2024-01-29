extends Area2D


var array_sandwich : Array = []
var logic_sandwich : Array = []
var inGroup = "table"
var detect_table : bool = false
var detect_trash : bool = false
var detect_client : Area2D = null

func _ready() -> void:
	area_entered.connect(_on_area_entered)

func ConnectDrop(hand):
	hand.Drop.connect(OnDrop)
	
func OnDrop(hand):
	if inGroup == "client":
		detect_client.CountPoints(self)
		get_parent().generator_plate()
		queue_free()
	hand.Drop.disconnect(OnDrop)


func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("table"):
		detect_table = true
		inGroup = "table"
	elif area.is_in_group("client"):
		detect_client = area
		inGroup = "client"
	print("client")


