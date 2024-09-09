extends Node2D

var changeSpeed : int
var speedRange = [0,0]
var targetSpeed : float
var curSpeed : float

enum CHANGE {STILL,SLOW,MODERATE,FAST,STORM}
var change:CHANGE = CHANGE.MODERATE

enum SPEED {CALM,BREEZE,STRONGBREEZE,GALE,STRONGGALE,STORM}
var speed:SPEED = SPEED.STORM

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

	match speed: # pressure managment
		SPEED.CALM:
			speedRange = [.1,2]
		SPEED.BREEZE:
			speedRange = [4,20]
		SPEED.STRONGBREEZE:
			speedRange = [20,39]
		SPEED.GALE:
			speedRange = [40,60]
		SPEED.STRONGGALE:
			speedRange = [61,99]
		SPEED.STORM:
			speedRange = [100,120]
		_:
			print("Invalid")

	targetSpeed = randf_range(speedRange[0],speedRange[1])
