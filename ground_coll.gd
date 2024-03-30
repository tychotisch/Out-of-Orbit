extends Polygon2D


func _ready() -> void:
	coll()



func coll() -> void:
	var collision_shape = CollisionPolygon2D.new()
	var line = Line2D.new()
	%StaticBody2D.add_child(line)
	
	line.points = polygon
	line.default_color = Color(5, 5, 5)
	line.width = 5
	%StaticBody2D.add_child(collision_shape)
	collision_shape.polygon = polygon
