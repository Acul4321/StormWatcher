extends Node2D

var changeSpeed : int
var tempRange = [0,0]
var targetTemp : float
var curTemp : float

enum CHANGE {STILL,SLOW,MODERATE,FAST,STORM}
var change:CHANGE = CHANGE.STILL

enum TEMP {FREEZING,LOW,AMBIENT,WARM,HOT,STORM}
var temp:TEMP = TEMP.FREEZING

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

	match temp: # pressure managment
		TEMP.FREEZING:
			tempRange = [30,50]
		TEMP.LOW:
			tempRange = [50,60]
		TEMP.AMBIENT:
			tempRange = [60,70]
		TEMP.WARM:
			tempRange = [70,80]
		TEMP.HOT:
			tempRange = [80,100]
		TEMP.STORM:
			tempRange = [50,100]
		_:
			print("Invalid")

	targetTemp = randf_range(tempRange[0],tempRange[1])
