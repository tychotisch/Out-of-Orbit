extends RigidBody2D

const ROTATION_SPEED := 900
const FUEL_BURN_RATE := 0.1

@export_range(5, 200) var thrust_amount = 10
#@export var fuel := 100.0
@export var local_gravity := 15

var alive := true
var game_over := false

func _ready() -> void:
	add_constant_force(Vector2(0, local_gravity), Vector2(0, 1))
	#Events.emit_signal("fuel_level", fuel)
	linear_velocity = Vector2(300, 0)
	emit_velocity()

func _physics_process(_delta: float) -> void:
	emit_velocity()
	if alive and !game_over:
		check_ground_collision()
		if !Global.fuel > 0:
			%ShipImage.on_thrust_ended()
			%ThrusterSound.stop_sound()
		else:
			set_rotation_direction()
			apply_thrust()
	else:
		%ThrusterSound.stop_sound()


func set_rotation_direction() -> void:
	var rotate_dir = Input.get_axis("left", "right")
	apply_torque(rotate_dir * ROTATION_SPEED)

func apply_thrust() -> void:
	var thrust_vector = Input.get_action_strength("up")
	if !thrust_vector:
		%ShipImage.on_thrust_ended()
		%ThrusterSound.stop_sound()
	else:
		%ShipImage.on_thrust_applied()
		var thrust = Vector2(0, -thrust_amount) * thrust_vector
		apply_force(thrust.rotated(rotation))
		burn_fuel()
		%ThrusterSound.play_sound()

func burn_fuel() -> void:
	Global.fuel -= FUEL_BURN_RATE

func emit_velocity() -> void:
	Events.emit_signal("horizontal_velocity", linear_velocity.x)
	Events.emit_signal("vertical_velocity", linear_velocity.y)

func check_landing_parameters() -> void:
	if linear_velocity.x / 3 < 5 and linear_velocity.y / 4 < 10 and %HorizontalIndicator.is_horizontal:
		game_over = true
		Events.emit_signal("you_won")
	else:
		explode_ship()

func explode_ship() -> void:
	alive = false
	%Dissolve.play("explode")
	await %Dissolve.animation_finished
	%Explosion.set_explosion_color("64d758")
	%Explosion.emitting = true
	%ExplosionSound.playing = true
	await %Explosion.finished
	Events.emit_signal("game_over")

func check_ground_collision() -> void:
	var bodies = get_colliding_bodies()
	if bodies and alive:
		for body in bodies:
			if body.is_in_group("ground"):
				explode_ship()
