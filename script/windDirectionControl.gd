extends Node2D
var curAngle : float
var targetAngle :float
var turnSpeed: float

var clockwise: bool
var tolerance:float
enum DIRECTION {NORTH,EAST,SOUTH,WEST,CURRENT}
var direction:DIRECTION = DIRECTION.CURRENT

enum STATE {STILL,CALM,MILD,HARD,INTENSE,STORM}
var state:STATE = STATE.HARD

func _physics_process(delta: float) -> void:
	moveHand(delta)
	Gameplay.windDirection = curAngle

func moveHand(delta):
	#current angle towards the target angle
	curAngle = rad_to_deg(%handPivot.rotation)
	#curAngle = wrapf(curAngle,0,360)
	if Helper.is_approx(curAngle,targetAngle,5): #true when hand reaches targetAngle
		stateLogic()
	if clockwise:
		curAngle += turnSpeed*delta
	else:
		curAngle -= turnSpeed*delta
	
	%handPivot.rotation = deg_to_rad(curAngle)

func stateLogic():
	match state: # state managment
		STATE.STILL:
			tolerance = 5
			turnSpeed = randf_range(.5,1)
		STATE.CALM:
			tolerance = 20
			turnSpeed = randf_range(2,7)
		STATE.MILD:
			tolerance = 45
			turnSpeed = randf_range(8,12)
		STATE.HARD:
			tolerance = 60
			turnSpeed = randf_range(30,60)
		STATE.INTENSE:
			tolerance = randf_range(60,180)
			turnSpeed = randf_range(200,300)
		STATE.STORM:
			tolerance = randf_range(210,360)
			turnSpeed = randf_range(500,600)
		_:
			print("Invalid")
	var facing:float
	match direction: # direction managment
		DIRECTION.NORTH:
			facing = 0
		DIRECTION.EAST:
			facing = 90
		DIRECTION.SOUTH:
			facing = 180
		DIRECTION.WEST:
			facing = 270
		DIRECTION.CURRENT:
			facing = curAngle
		_:
			print("Invalid")
	targetAngle = randf_range(facing-tolerance,facing+tolerance)
	clockwise = findShortestDir()
	#print("targetAngle: " +str(targetAngle)+",turnSpeed: "+str(turnSpeed))
	
##helper functions ##
func findShortestDir():
	#print(fmod((targetAngle-curAngle),360))
	var dif = 2
	#print(abs(targetAngle -curAngle + dif))
	#print(abs( targetAngle - curAngle - dif))
	#print(abs(targetAngle - curAngle + dif) > abs(targetAngle - curAngle - dif))
	if abs(targetAngle - curAngle + dif) > abs(targetAngle - curAngle - dif):
		return true
	else:
		return false 
