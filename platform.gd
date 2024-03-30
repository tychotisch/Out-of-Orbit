extends StaticBody2D

@export var score_amount := 5


func _ready() -> void:
	%Label.text = str(score_amount) + " X"

