extends Control

#Use an autoloaded script for the signals (Events) and uncomment the signals
#Autoload or instance this scene
#Use Signals to call the various menus

#Pause menu called by enter. if enter is pressed menu will unpause or reset

@export var start_level : PackedScene
var game_over := false
var paused := false

func _ready() -> void:
	connect_signals()

func set_title(value: String) -> void:
	%MenuTitle.text = value

func _on_start_button_pressed() -> void:
	get_tree().paused = false
	hide()
	paused = false

func _on_reset_button_pressed() -> void:
	get_tree().paused = false
	if !start_level:
		get_tree().reload_current_scene()
		set_reset_state()
	else:
		get_tree().change_scene_to_packed(start_level)
	#Events.emit_signal("reset_game")
	hide()
	paused = false
	game_over = false

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func show_paused() -> void:
	if !game_over and !paused:
		paused = true
		set_title("Paused")
		get_tree().paused = true
		%StartButton.text = "Resume"
		%StartButton.show()
		show()

func show_game_over() -> void:
	if !paused and !game_over:
		game_over = true
		set_title("Game Over")
		get_tree().paused = true
		%StartButton.hide()
		%ResetButton.show()
		show()

func show_start() -> void:
	if !paused and !game_over:
		paused = true
		set_title("Out of Orbit")
		%StartButton.text = "Start Game"
		get_tree().paused = true
		%ResetButton.hide()
		show()

func connect_signals() -> void:
	Events.connect("game_over", show_game_over)
	Events.connect("pause_game", show_paused)
	Events.connect("show_start", show_start)
	%StartButton.connect("pressed", _on_start_button_pressed)
	%ResetButton.connect("pressed", _on_reset_button_pressed)
	%QuitButton.connect("pressed", _on_quit_button_pressed)

func set_reset_state() -> void:
	Global.fuel = Global.start_fuel
	Global.score = 0

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		show_paused()
	if event.is_action_pressed("ui_accept"):
		if paused and !game_over:
			_on_start_button_pressed()
		if !paused and game_over:
			_on_reset_button_pressed()
