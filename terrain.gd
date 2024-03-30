extends Node2D

@export var terrain_texture := CompressedTexture2D
@export var num_hils := 2
@export var hill_range := 100

var slice := 10
var screen_size 
var terrain := []


@onready var platforms := $Platforms

func _ready() -> void:
	randomize()
	screen_size = get_viewport().get_visible_rect().size
	terrain = []
	var start_y = screen_size.y * 9/10 + (-hill_range + randi() % hill_range * 2)
	terrain.append(Vector2(0, start_y))
	add_hills(-1)
	add_hills(1)
	

func _process(_delta: float) -> void:
	if terrain[-1].x < %Player.position.x + screen_size.x / 2:
		add_hills(1)

func add_hills(hill_direction : int):
	var hill_width = screen_size.x / num_hils
	var hill_slices = hill_width / slice 
	var start = terrain[-1]
	var poly = PackedVector2Array()
	for i in range(num_hils):
		var height = randi() % hill_range
		start.y -= height
		for j in range(0, hill_slices):
			var hill_point = Vector2()
			hill_point.x = start.x + (j * hill_direction) * slice + (hill_width * hill_direction) * i
			hill_point.y = start.y + height * cos(2 * PI / hill_slices * j)
			%Line2D.add_point(hill_point)
			terrain.append(hill_point)
			poly.append(hill_point)
		start.y += height
	#flatten_area(poly, 10)
	create_platform(poly, 10, Color(0,1,0))
	var shape = CollisionPolygon2D.new()
	var ground = Polygon2D.new()
	
	%StaticBody2D.add_child(shape)
	poly.append(Vector2(terrain[-1].x, screen_size.y))
	poly.append(Vector2(start.x, screen_size.y))
	shape.polygon = poly
	ground.polygon = poly
	ground.texture = terrain_texture
	ground.color = Color(0, 0, 0)
	add_child(ground)
	#return poly
	
	

func flatten_area(points: PackedVector2Array, index: int):
	points[index -2].y = points[index].y
	points[index -1].y = points[index].y
	points[index +1].y = points[index].y
	points[index +2].y = points[index].y

func create_platform(points: PackedVector2Array, index: int, color: Color):
	var platform_line = Line2D.new()
	platform_line.points = [points[index -2], points[index +2]]
	platform_line.default_color = color
	platform_line.width = 10
	platform_line.z_index = 2
	platforms.add_child(platform_line)
