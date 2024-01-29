extends Area2D
class_name  Item
var new_position_item = preload("res://scenes/position_item.tscn")

var old_position : Vector2 = Vector2.ZERO
var detect_table : bool = false
var detect_trash : bool = false
var detect_plate : bool = false
var selected : bool = false
var plate : Area2D = null
var Type : String
var inGroup = "trash"
var mouse_offset : Vector2 = Vector2(0, 0)
var sfx : String
var message : String
signal dialogue

func _ready() -> void:
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("table"):
		detect_table = true
		inGroup = "table"
	elif area.is_in_group("trash"):
		detect_trash = true
		inGroup = "trash"
	elif area.is_in_group("plate"):
		detect_plate = true
		inGroup = "plate"
		plate = area

func _on_area_exited(area: Area2D) -> void:
	if area.is_in_group("table"):
		detect_table = false
		print(detect_table)
	if area.is_in_group("trash"):
		detect_trash = false
		print(detect_trash)
	if area.is_in_group("plate"):
		detect_plate = false
		plate = null

func Construct(ItemType, ItemSprite, itemSfx : String, itemMessage : String):
	Type = ItemType
	$Sprite2D.texture  =  ItemSprite
	sfx = itemSfx
	message = itemMessage

func ConnectDrop(x):
	x.Drop.connect(OnDrop)
	
func OnDrop(hand):
	print(inGroup)
	if inGroup == "trash" :
		queue_free()
	if inGroup == "plate":
		if plate == null : return
		if sfx: SoundManager.play("res://Sounds/SFX/" + sfx + ".wav")
		DialogueTrigger()
		var item_with_food = new_position_item.instantiate()
		item_with_food.get_node("Sprite2D").texture = $Sprite2D.texture
		item_with_food.position.y = -8
		plate.add_child(item_with_food)
		
		if(plate.array_sandwich.size() == 0):
			item_with_food.position = Vector2.ZERO
		elif plate.array_sandwich[plate.array_sandwich.size()-1] != null:
			item_with_food.position.y += plate.array_sandwich[plate.array_sandwich.size()-1].position.y  -24
		plate.array_sandwich.append(item_with_food)
		plate.logic_sandwich.append(Type)
		queue_free()
			
	hand.Drop.disconnect(OnDrop)

func DialogueTrigger():
	if(randi_range(0,5) != 1): return
	dialogue.emit(message,plate.get_parent())
