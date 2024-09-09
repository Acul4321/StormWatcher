extends Node2D

@export var clouds: Array[CompressedTexture2D]
var cloudDensity:int
var spawnedClouds: Array[Sprite2D]
var spawnLoc:float

func _ready() -> void:
	stateLogic()

func _process(delta: float) -> void:
	if cloudDensity > randi_range(0,1000):
		spawnCloud()
	
	var dir = Helper.vectorFromAngleAndSpeed(Gameplay.windDirection - 90,Gameplay.windSpeed) # cloud movment
	dir = dir/200
	for cloud in spawnedClouds:
		cloud.global_position = cloud.global_position + dir
	#spawm storm at specific direction

func spawnCloud():
	var index : int
	if Gameplay.spawnStormCloud:
		index = clouds.size()-1
		Gameplay.spawnStormCloud = false
	else:
		index = randf_range(0,clouds.size()-1)
		
	var cloudPath = clouds[index].load_path
	
	var cloud = Sprite2D.new()
	cloud.texture = load(cloudPath)
	cloud.rotation = randf_range(0,deg_to_rad(360))
	
	match Gameplay.cloudSpawnDir: # spawn location managment
		Gameplay.CLOUDDIRECTION.NORTH:
			spawnLoc = randf_range(0,0.25)
		Gameplay.CLOUDDIRECTION.EAST:
			spawnLoc = randf_range(0.25,0.5)
		Gameplay.CLOUDDIRECTION.SOUTH:
			spawnLoc = randf_range(0.5,0.75)
		Gameplay.CLOUDDIRECTION.WEST:
			spawnLoc = randf_range(0.75,1)
		Gameplay.CLOUDDIRECTION.RAND:
			spawnLoc = randf_range(0,1)
		_:
			print("invalid")
	%spawnPoint.progress_ratio = spawnLoc
	cloud.position = %spawnPoint.position
	
	add_child(cloud)
	spawnedClouds.append(cloud)

func stateLogic():
	match Gameplay.cloudType: # state managment
		Gameplay.CLOUDTYPE.CLEAR:
			cloudDensity = 1
		Gameplay.CLOUDTYPE.LIGHT:
			cloudDensity = 5
		Gameplay.CLOUDTYPE.CLOUDY:
			cloudDensity = 10
		Gameplay.CLOUDTYPE.DENSE:
			cloudDensity = 30
		Gameplay.CLOUDTYPE.STORM:
			cloudDensity = 50
		_:
			print("Invalid")
