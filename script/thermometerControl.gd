extends Node2D

var changeSpeed : int
var tempRange = [0,0]
var targetTemp : float
var curTemp : float

func _ready():
	curTemp = 0
	stateLogic()

func _process(delta: float) -> void:
	if Helper.is_approx(curTemp,targetTemp,5):
		stateLogic()
	if curTemp <= targetTemp:
		curTemp += changeSpeed*delta
	else:
		curTemp -= changeSpeed*delta
		
	%tempBar.value = curTemp

func stateLogic():
	match Gameplay.tempChange: # state managment
		Gameplay.TEMPCHANGE.STILL:
			changeSpeed = 1
		Gameplay.TEMPCHANGE.SLOW:
			changeSpeed = 5
		Gameplay.TEMPCHANGE.MODERATE:
			changeSpeed = 20
		Gameplay.TEMPCHANGE.FAST:
			changeSpeed = 100
		Gameplay.TEMPCHANGE.STORM:
			changeSpeed = 500
		_:
			print("Invalid")

	match Gameplay.temp: # pressure managment
		Gameplay.TEMP.FREEZING:
			tempRange = [30,50]
		Gameplay.TEMP.LOW:
			tempRange = [50,60]
		Gameplay.TEMP.AMBIENT:
			tempRange = [60,70]
		Gameplay.TEMP.WARM:
			tempRange = [70,80]
		Gameplay.TEMP.HOT:
			tempRange = [80,100]
		Gameplay.TEMP.STORM:
			tempRange = [50,100]
		_:
			print("Invalid")

	targetTemp = randf_range(tempRange[0],tempRange[1])
