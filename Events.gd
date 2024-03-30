extends Node

# Auto-loaded node that only emits signals.
# Any node in the game can use it to emit signals, like so:
	
	# Events.emit_signal("mob_died", 10)

# Any node in the game can connect to the events:

	#Events.connect("mob_died", update_score)

# Game_over calls the game over menu
# Pause_game calls the pause menu
# Show_start call the start menu

signal game_over()
signal pause_game()
signal show_start()
signal you_won()
signal platform(value)

# Ship signals
signal fuel_level(amount)
signal horizontal_velocity(vel_x)
signal vertical_velocity(vel_y)
signal is_horizontal(bool)
