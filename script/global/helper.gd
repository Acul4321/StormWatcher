extends Node

##helper functions ##
func is_approx(val1,val2,epsilon):
	if val1 > val2 - epsilon and val1 < val2 + epsilon :
		return true
	else:
		return false
		
func vectorFromAngleAndSpeed(angle_degrees: float, speed: float) -> Vector2:
	# Convert angle from degrees to radians
	var angle_radians = deg_to_rad(angle_degrees)
	
	# Calculate the x and y components of the vector
	var x = cos(angle_radians) * speed
	var y = sin(angle_radians) * speed
	
	# Return the resulting vector
	return Vector2(x, y)
