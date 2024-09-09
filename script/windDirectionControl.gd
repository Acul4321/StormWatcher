extends Node2D
var curAngle : float
var targetAngle :float
var turnSpeed: float

var clockwise: bool
var tolerance:float

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
	match Gameplay.windDirectionState: # state managment
		Gameplay.WINDDIRECTIONSTATE.STILL:
			tolerance = 5
			turnSpeed = randf_range(.5,1)
		Gameplay.WINDDIRECTIONSTATE.CALM:
			tolerance = 20
			turnSpeed = randf_range(2,7)
		Gameplay.WINDDIRECTIONSTATE.MILD:
			tolerance = 45
			turnSpeed = randf_range(8,12)
		Gameplay.WINDDIRECTIONSTATE.HARD:
			tolerance = 60
			turnSpeed = randf_range(30,60)
		Gameplay.WINDDIRECTIONSTATE.INTENSE:
			tolerance = randf_range(60,180)
			turnSpeed = randf_range(200,300)
		Gameplay.WINDDIRECTIONSTATE.STORM:
			tolerance = randf_range(210,360)
			turnSpeed = randf_range(500,600)
		_:
			print("Invalid")
	var facing:float
	match Gameplay.windDirectionBias: # direction managment
		Gameplay.WINDDIRECTIONBIAS.NORTH:
			facing = 0
		Gameplay.WINDDIRECTIONBIAS.EAST:
			facing = 90
		Gameplay.WINDDIRECTIONBIAS.SOUTH:
			facing = 180
		Gameplay.WINDDIRECTIONBIAS.WEST:
			facing = 270
		Gameplay.WINDDIRECTIONBIAS.CURRENT:
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
