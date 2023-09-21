extends Label

func _process(delta):
	var player = $player

	if player != null:
		var player_health = player.health
		text = "Vida del Jugador: " + str(player_health)
	else:
		text = "Esperando al jugador..."
