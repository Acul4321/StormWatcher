extends Node2D

var changeSpeed : int
var speedRange = [0,0]
var targetSpeed : float
var curSpeed : float

func _ready():
	curSpeed = 0
	stateLogic()

func _process(delta: float) -> void:
	if Helper.is_approx(curSpeed,targetSpeed,5):
		stateLogic()
	if curSpeed <= targetSpeed:
		curSpeed += changeSpeed*delta
	else:
		curSpeed -= changeSpeed*delta
		
	var newText = str(snappedf(curSpeed,1))
	Gameplay.windSpeed = snappedf(curSpeed,1)
	for i in range(abs(newText.length()-3)): #formating for easy viewing
		newText = "0" + newText
		
	%speedText.text = newText + "KM/H"

func stateLogic():
	match Gameplay.windSpeedChange: # state managment
		Gameplay.WINDSPEEDCHANGE.STILL:
			changeSpeed = 1
		Gameplay.WINDSPEEDCHANGE.SLOW:
			changeSpeed = 5
		Gameplay.WINDSPEEDCHANGE.MODERATE:
			changeSpeed = 20
		Gameplay.WINDSPEEDCHANGE.FAST:
			changeSpeed = 100
		Gameplay.WINDSPEEDCHANGE.STORM:
			changeSpeed = 500
		_:
			print("Invalid")

	match Gameplay.windSpeedState: # pressure managment
		Gameplay.WINDSPEEDSTATE.CALM:
			speedRange = [.1,2]
		Gameplay.WINDSPEEDSTATE.BREEZE:
			speedRange = [4,20]
		Gameplay.WINDSPEEDSTATE.STRONGBREEZE:
			speedRange = [20,39]
		Gameplay.WINDSPEEDSTATE.GALE:
			speedRange = [40,60]
		Gameplay.WINDSPEEDSTATE.STRONGGALE:
			speedRange = [61,99]
		Gameplay.WINDSPEEDSTATE.STORM:
			speedRange = [100,120]
		_:
			print("Invalid")

	targetSpeed = randf_range(speedRange[0],speedRange[1])
