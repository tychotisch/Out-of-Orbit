extends CPUParticles2D


func set_explosion_color(value: String) -> void:
	var explosion_color = value
	modulate = Color.html(explosion_color)
