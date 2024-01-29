extends Node2D
@export var ItemType: String
@export var ItemSprite : Texture2D
@export var sfx : String
@export var message : String
@export var Dialogue1 : Control
@export var Dialogue2 : Control

var instancia = load("res://scenes/item.tscn")
var item

func _ready():
	InstanciateItem()
	
func _process(delta):
	for i in get_children():
		if i.position == Vector2.ZERO:
			return
		else:
			InstanciateItem()

func InstanciateItem():
	if ItemType == "bad":
		await get_tree().create_timer(randf_range(5,15)).timeout
	var _item = instancia.instantiate()
	add_child(_item)
	_item.global_position = global_position
	_item.Construct(ItemType, ItemSprite, sfx, message)
	Dialogue1.ConnectItem(_item)
	Dialogue2.ConnectItem(_item)
	
