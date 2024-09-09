extends Node2D

var changeSpeed : int
var rainRange = [0,0]
var targetRain : float
var curRain : float

func _ready():
	curRain = 0
	stateLogic()

func _process(delta: float) -> void:
	if Helper.is_approx(curRain,targetRain,5):
		stateLogic()
	if curRain <= targetRain:
		curRain += changeSpeed*delta
	else:
		curRain -= changeSpeed*delta
		
	%rainBar.value = curRain

func stateLogic():
	match Gameplay.rainChange: # state managment
		Gameplay.RAINCHANGE.STILL:
			changeSpeed = 1
		Gameplay.RAINCHANGE.SLOW:
			changeSpeed = 5
		Gameplay.RAINCHANGE.MODERATE:
			changeSpeed = 20
		Gameplay.RAINCHANGE.FAST:
			changeSpeed = 100
		Gameplay.RAINCHANGE.STORM:
			changeSpeed = 500
		_:
			print("Invalid")

	match Gameplay.rain: # pressure managment
		Gameplay.RAIN.DRY:
			rainRange = [0,0]
		Gameplay.RAIN.DRIZZLE:
			rainRange = [10,20]
		Gameplay.RAIN.RAIN:
			rainRange = [30,50]
		Gameplay.RAIN.HEAVY:
			rainRange = [60,80]
		Gameplay.RAIN.STORM:
			rainRange = [95,100]
		_:
			print("Invalid")

	targetRain = randf_range(rainRange[0],rainRange[1])
