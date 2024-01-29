extends CharacterBody2D

@export var max_speed = 100
@export var acceleration = 800
@export var friction = 800
@export var player2 : bool
@onready var Sprite = $Sprite2D


var once
var direction: Vector2
signal hit
var isGrabing : bool
signal Drop
signal grab
signal Instanciate
var raycast : RayCast2D
var inAreaHand
var idleHand = load("res://HandController/standard-key frame - grip - test.png")
var gabHand = load("res://HandController/Grip-key frame - grip - test.png")
var item
var plate

func _ready():
	raycast = $RayCast2D

func _physics_process(delta):
	Move(delta)
	if(isGrabing) : GrabAnObject()

func _input(event):
	if !player2:
		inputCheck("grab")
	if player2:
		inputCheck("grab_2")

func inputCheck(x):
	if Input.is_action_just_pressed(x):
		if !isGrabing :
			Sprite.texture = gabHand
			isGrabing = true
			if raycast.get_collider() == null : return
			if raycast.get_collider() is CharacterBody2D:
				SoundManager.play("res://Sounds/SFX/cachetada.wav")
				hit.emit()
				PlaySlap()
			elif raycast.get_collider().is_in_group("item"):
				SoundManager.play("res://Sounds/SFX/agarrar2.wav")
				item = raycast.get_collider()
			elif raycast.get_collider().is_in_group("plate"):
				plate = raycast.get_collider()
		else:
			Sprite.texture = idleHand
			isGrabing =false
			plate = null
			item = null
			once = false
		#	item.selected = false
			Drop.emit(self)

func Move(delta):
	if direction == Vector2.ZERO:
		Apply_Friction(friction * delta)
	
	if !player2:
		direction.x = Input.get_axis("ui_left","ui_right")
		direction.y = Input.get_axis("ui_up","ui_down")
	else :
		direction.x = Input.get_axis("ui_left_2","ui_rigth_2")
		direction.y = Input.get_axis("ui_up_2","ui_down_2")
		
	Apply_Movement(direction * acceleration * delta)
	
	move_and_slide()

func Apply_Friction(amount):
	if velocity.length() > amount:
		velocity -= velocity.normalized() * amount
	else: velocity = Vector2.ZERO
	
func Apply_Movement(accel):
	velocity += accel
	velocity = velocity.limit_length(max_speed)

func GetHit():
	Drop.emit(self)
	isGrabing=false
	item = null
	plate = null
	#item.selected = false
	Sprite.texture = idleHand
	once = false

func PlaySlap():
	$AnimationPlayer.play("slap")

func GrabAnObject():
	var aux
	if item != null:
		item.global_position = global_position  
		aux = item.position
		aux.y = item.position.y - 70
		item.position = aux
		if once: return
		item.ConnectDrop(self)
		once = true 
	if plate != null:
		plate.global_position = global_position  
		aux = plate.position
		aux.y = plate.position.y - 70
		plate.position = aux
		if once: return
		plate.ConnectDrop(self)
		once = true 
#	item.selected = true
