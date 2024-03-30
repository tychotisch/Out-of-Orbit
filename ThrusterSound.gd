extends AudioStreamPlayer

var playing_sound := false

func play_sound() -> void:
	if !playing_sound:
		playing_sound = true
		playing = true

func stop_sound() -> void:
	if playing_sound:
		playing_sound = false
		playing = false
