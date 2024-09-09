extends Node2D

@export var clouds: Array[CompressedTexture2D]
var cloudDensity:int
var spawnedClouds: Array[Sprite2D]
var Storm = false

enum DIRECTION {NORTH,EAST,SOUTH,WEST}

enum TYPE {CLEAR,LIGHT,CLOUDY,DENSE,STORM}
var type:TYPE = TYPE.DENSE

func _ready() -> void:
	stateLogic()

func _process(delta: float) -> void:
	if cloudDensity > randi_range(0,1000):
		spawnCloud(Storm)
	
	var dir = Helper.vectorFromAngleAndSpeed(Gameplay.windDirection - 90,Gameplay.windSpeed) # cloud movment
	dir = dir/200
	for cloud in spawnedClouds:
		cloud.global_position = cloud.global_position + dir
	#spawm storm at specific direction

func spawnCloud(storm,spawnBias = 0,tolerance = 0):
	var index : int
	if storm:
		index = randf_range(0,clouds.size())
	else:
		index = randf_range(0,clouds.size()-1)
		
	var cloudPath = clouds[index].load_path
	
	var cloud = Sprite2D.new()
	cloud.texture = load(cloudPath)
	cloud.rotation = randf_range(0,deg_to_rad(360))
	
	%spawnPoint.progress_ratio = randf_range(0,1)
	cloud.position = %spawnPoint.position
	
	add_child(cloud)
	spawnedClouds.append(cloud)

func stateLogic():
	match type: # state managment
		TYPE.CLEAR:
			cloudDensity = 1
		TYPE.LIGHT:
			cloudDensity = 5
		TYPE.CLOUDY:
			cloudDensity = 10
		TYPE.DENSE:
			cloudDensity = 30
		TYPE.STORM:
			cloudDensity = 50
		_:
			print("Invalid")
