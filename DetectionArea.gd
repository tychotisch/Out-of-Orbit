extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.check_landing_parameters()
		var score = get_parent().score_amount
		Events.emit_signal("platform", score)
