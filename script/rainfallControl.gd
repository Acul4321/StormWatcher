extends Node2D

var changeSpeed : int
var rainRange = [0,0]
var targetRain : float
var curRain : float

enum CHANGE {STILL,SLOW,MODERATE,FAST,STORM}
var change:CHANGE = CHANGE.STORM

enum RAIN {DRY,DRIZZLE,RAIN,HEAVY,STORM}
var rain:RAIN = RAIN.STORM

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
	match change: # state managment
		CHANGE.STILL:
			changeSpeed = 1
		CHANGE.SLOW:
			changeSpeed = 5
		CHANGE.MODERATE:
			changeSpeed = 20
		CHANGE.FAST:
			changeSpeed = 100
		CHANGE.STORM:
			changeSpeed = 500
		_:
			print("Invalid")

	match rain: # pressure managment
		RAIN.DRY:
			rainRange = [0,0]
		RAIN.DRIZZLE:
			rainRange = [10,20]
		RAIN.RAIN:
			rainRange = [30,50]
		RAIN.HEAVY:
			rainRange = [60,80]
		RAIN.STORM:
			rainRange = [95,100]
		_:
			print("Invalid")

	targetRain = randf_range(rainRange[0],rainRange[1])
