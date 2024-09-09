extends Node2D

var scrollSpeed = 50
var xCutoff = -200
var pressureGraph = []

var changeSpeed : int
var pressureRange = [0,0]
var targetY : float
var curY : float

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
	match Gameplay.atmosphericChange: # state managment
		Gameplay.ATMOSPHERICCHANGE.STILL:
			changeSpeed = 5
		Gameplay.ATMOSPHERICCHANGE.SLOW:
			changeSpeed = 20
		Gameplay.ATMOSPHERICCHANGE.MODERATE:
			changeSpeed = 50
		Gameplay.ATMOSPHERICCHANGE.FAST:
			changeSpeed = 100
		Gameplay.ATMOSPHERICCHANGE.STORM:
			changeSpeed = 500
		_:
			print("Invalid")

	match Gameplay.atmosphericPressure: # pressure managment
		Gameplay.ATMOSPHERICPRESSURE.LOW:
			pressureRange = [66,100]
		Gameplay.ATMOSPHERICPRESSURE.LOWMED:
			pressureRange = [33,100]
		Gameplay.ATMOSPHERICPRESSURE.MEDIUM:
			pressureRange = [33,66]
		Gameplay.ATMOSPHERICPRESSURE.MEDHIGH:
			pressureRange = [0,66]
		Gameplay.ATMOSPHERICPRESSURE.HIGH:
			pressureRange = [0,33]
		Gameplay.ATMOSPHERICPRESSURE.STORM:
			pressureRange = [0,100]
		_:
			print("Invalid")

	targetY = randf_range(pressureRange[0],pressureRange[1])
