extends Camera2D
var smooth_speed = 0.125
var offset1 = Vector2(0, 0)
func _ready():
	var desired_position = get_parent().get_position_delta() + offset1
	var smoothed_position = desired_position.lerp(position, smooth_speed)
