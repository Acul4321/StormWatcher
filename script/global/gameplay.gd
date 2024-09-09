extends Node

func _ready() -> void:
	#changeWindDirection(WINDDIRECTIONSTATE.CALM,WINDDIRECTIONBIAS.NORTH)
	#changeWindSpeed(WINDSPEEDSTATE.BREEZE, WINDSPEEDCHANGE.MODERATE)
	#changeAtmosphericPressure(ATMOSPHERICPRESSURE.HIGH,ATMOSPHERICCHANGE.FAST)
	#changeTemp(TEMP.FREEZING,TEMPCHANGE.STORM)
	#changeCloud(CLOUDTYPE.DENSE,CLOUDDIRECTION.EAST, true)
	pass

##windDirectionInst##
enum WINDDIRECTIONBIAS {NORTH,EAST,SOUTH,WEST,CURRENT}
var windDirectionBias:WINDDIRECTIONBIAS = WINDDIRECTIONBIAS.SOUTH
enum WINDDIRECTIONSTATE {STILL,CALM,MILD,HARD,INTENSE,STORM}
var windDirectionState:WINDDIRECTIONSTATE = WINDDIRECTIONSTATE.HARD
var windDirection:float
func changeWindDirection(state:WINDDIRECTIONSTATE,bias:WINDDIRECTIONBIAS): #control windDirection
	windDirectionBias = bias
	windDirectionState = state

##windSpeedInst##
enum WINDSPEEDSTATE {CALM,BREEZE,STRONGBREEZE,GALE,STRONGGALE,STORM}
var windSpeedState:WINDSPEEDSTATE = WINDSPEEDSTATE.STORM
enum WINDSPEEDCHANGE {STILL,SLOW,MODERATE,FAST,STORM}
var windSpeedChange:WINDSPEEDCHANGE = WINDSPEEDCHANGE.MODERATE
var windSpeed:float
func changeWindSpeed(state:WINDSPEEDSTATE,change:WINDSPEEDCHANGE): #control windSpeed
	windSpeedState = state
	windSpeedChange = change

##atmosphericPressureInst##
enum ATMOSPHERICPRESSURE {LOW,LOWMED,MEDIUM,MEDHIGH,HIGH,STORM}
var atmosphericPressure:ATMOSPHERICPRESSURE = ATMOSPHERICPRESSURE.LOW
enum ATMOSPHERICCHANGE {STILL,SLOW,MODERATE,FAST,STORM}
var atmosphericChange:ATMOSPHERICCHANGE = ATMOSPHERICCHANGE.STILL
func changeAtmosphericPressure(state:ATMOSPHERICPRESSURE,change:ATMOSPHERICCHANGE): #control windSpeed
	atmosphericPressure = state
	atmosphericChange = change

##thermometerInst##
enum TEMP {FREEZING,LOW,AMBIENT,WARM,HOT,STORM}
var temp:TEMP = TEMP.WARM
enum TEMPCHANGE {STILL,SLOW,MODERATE,FAST,STORM}
var tempChange:TEMPCHANGE = TEMPCHANGE.MODERATE
func changeTemp(state:TEMP,change:TEMPCHANGE): #control Temperature
	temp = state
	tempChange = change

##rainfallInst##
enum RAIN {DRY,DRIZZLE,RAIN,HEAVY,STORM}
var rain:RAIN = RAIN.STORM
enum RAINCHANGE {STILL,SLOW,MODERATE,FAST,STORM}
var rainChange:RAINCHANGE = RAINCHANGE.STORM
func changeRain(state:RAIN,change:RAINCHANGE): #control Rainfall
	rain = state
	rainChange = RAINCHANGE

##cloudRadarInst##
enum CLOUDTYPE {CLEAR,LIGHT,CLOUDY,DENSE,STORM}
var cloudType:CLOUDTYPE = CLOUDTYPE.DENSE
enum CLOUDDIRECTION {NORTH,EAST,SOUTH,WEST,RAND}
var cloudSpawnDir : CLOUDDIRECTION = CLOUDDIRECTION.WEST
var spawnStormCloud: bool = false
func changeCloud(state:CLOUDTYPE,bias:CLOUDDIRECTION,storm:bool = false): #control clouds
	cloudType = state
	cloudSpawnDir = bias
	spawnStormCloud = storm
