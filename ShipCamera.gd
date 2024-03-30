extends Camera2D

var start_zoom_in := false
var max_zoom = Vector2(2, 2)
var min_zoom = Vector2(0.5, 0.5)
var zoom_speed = Vector2(1, 1)

func _ready() -> void:
	zoom = min_zoom

func _physics_process(delta: float) -> void:
	if %RayCast.is_colliding():
		start_zoom_in = true
	
	if start_zoom_in:
		if zoom < max_zoom:
			zoom += zoom_speed * delta
		
