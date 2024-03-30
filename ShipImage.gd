extends Sprite2D

var thrust_applied := false

func _ready() -> void:
	%Dissolve.play("RESET")

func on_thrust_applied() -> void:
	if !thrust_applied:
		thrust_applied = true
		%BeamAnimation.play("beam_ease_in")
		%FlameAnimation.play("flaming")
		%CPUParticles2D.emitting = true

func on_thrust_ended() -> void:
	if thrust_applied:
		thrust_applied = false
		%CPUParticles2D.emitting = false
		%FlameAnimation.stop()
		%BeamAnimation.play("beam_ease_out")



