extends Node2D

var scrollSpeed = 50
var xCutoff = -200
var pressureGraph = []

var changeSpeed : int
var pressureRange = [0,0]
var targetY : float
var curY : float

enum CHANGE {STILL,SLOW,MODERATE,FAST,STORM}
var change:CHANGE = CHANGE.STILL

enum PRESSURE {LOW,LOWMED,MEDIUM,MEDHIGH,HIGH,STORM}
var pressure:PRESSURE = PRESSURE.LOW

func _ready():
	curY = 100
	stateLogic()

func _process(delta: float) -> void:
	for x in pressureGraph: # move graph to the left
		x[0] -= scrollSpeed*delta
		if x[0] <= xCutoff:
			pressureGraph.pop_front() #remove eccess points
			
	if Helper.is_approx(curY,targetY,5):
		stateLogic()
	if curY <= targetY:
		curY += changeSpeed*delta
	else:
		curY -= changeSpeed*delta
	pressureGraph.append([0,curY])
	queue_redraw() # redraw every frame

func _draw() -> void:
	for i in range(pressureGraph.size()-1):
		var start = Vector2(pressureGraph[i][0],pressureGraph[i][1])
		var end = Vector2(pressureGraph[i+1][0],pressureGraph[i+1][1])
		draw_line(start, end, Color.GREEN, 3.0)

func stateLogic():
	match change: # state managment
		CHANGE.STILL:
			changeSpeed = 5
		CHANGE.SLOW:
			changeSpeed = 20
		CHANGE.MODERATE:
			changeSpeed = 50
		CHANGE.FAST:
			changeSpeed = 100
		CHANGE.STORM:
			changeSpeed = 500
		_:
			print("Invalid")

	match pressure: # pressure managment
		PRESSURE.LOW:
			pressureRange = [66,100]
		PRESSURE.LOWMED:
			pressureRange = [33,100]
		PRESSURE.MEDIUM:
			pressureRange = [33,66]
		PRESSURE.MEDHIGH:
			pressureRange = [0,66]
		PRESSURE.HIGH:
			pressureRange = [0,33]
		PRESSURE.STORM:
			pressureRange = [0,100]
		_:
			print("Invalid")

	targetY = randf_range(pressureRange[0],pressureRange[1])
