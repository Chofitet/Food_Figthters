extends Area2D

@export var BaseLog : float
var cantIng : float
var Points : float
var _points
var lesPoints : int = 30

func _ready():
	_points = $Points
	
func CountPoints(sanguche):
	SoundManager.play("res://Sounds/SFX/entrega cortado.wav")
	for i in sanguche.logic_sandwich:
		if i == "good":
			cantIng += 1
			Points += CalculatePoints()
		elif i == "bad":
			Points -= lesPoints
			pass
	_points.text = str(Points)
	
func CalculatePoints() -> int:
	var i
	i =  round(pow(BaseLog, cantIng))
	print(i)
	return i
