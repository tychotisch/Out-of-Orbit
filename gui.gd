extends CanvasLayer


func _ready() -> void:
	#Events.connect("fuel_level", set_fuel)
	Events.connect("horizontal_velocity", set_velocity_x)
	Events.connect("vertical_velocity", set_velocity_y)
	Events.connect("you_won", set_win_state)
	Events.connect("platform", score_multiplier)
	%FuelAmountLabel.text = str(int(Global.fuel))
	set_score()


func _process(_delta: float) -> void:
	%FuelAmountLabel.text = str(int(Global.fuel))


func set_velocity_x(vel_x) -> void:
	var horizontal_velocity = vel_x / 3
	%HorizontalSpeedAmountLabel.text = str(int(horizontal_velocity))
	if horizontal_velocity <= 5 and horizontal_velocity >= -5:
		%HorizontalSpeedAmountLabel.modulate = Color(0, 160, 0)
	else:
		%HorizontalSpeedAmountLabel.modulate = Color(255, 255, 255)

func set_velocity_y(vel_y) -> void:
	var vertical_velocity = vel_y / 4
	%VerticalSpeedAmountLabel.text = str(int(vertical_velocity))
	if vertical_velocity <= 10:
		%VerticalSpeedAmountLabel.modulate = Color(0, 160, 0)
	else:
		%VerticalSpeedAmountLabel.modulate = Color(255, 255, 255)

func set_score() -> void:
	%ScoreAmountLabel.text = str(Global.score)

func set_win_state() -> void:
	Global.score = Global.score + int(Global.fuel)
	%AnimationPlayer.play("win_anim")
	await %AnimationPlayer.animation_finished
	get_tree().reload_current_scene()

func score_multiplier(value) -> void:
	Global.score = Global.score * value
	set_score()
