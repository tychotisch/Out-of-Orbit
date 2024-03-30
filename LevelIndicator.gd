extends Node2D

var parent_rotation 
var horizontal_color = Color(0, 160, 0)
var non_horizontal_color = Color(255, 255, 255)
var is_horizontal := false

func _process(_delta):
	parent_rotation = get_parent().rotation
	set_rotation(- parent_rotation)
	check_horizontal()


func check_horizontal() -> void:
	var angle = rotation_degrees
	if angle < -5 or angle > 5:
		is_horizontal = false
		%HorizontalLine.default_color = non_horizontal_color
		%HorzizontalLine2.default_color = non_horizontal_color
		%LevelLine.default_color = non_horizontal_color
		%LevelLine2.default_color = non_horizontal_color
	else:
		is_horizontal = true
		%HorizontalLine.default_color = horizontal_color
		%HorzizontalLine2.default_color = horizontal_color
		%LevelLine.default_color = horizontal_color
		%LevelLine2.default_color = horizontal_color
