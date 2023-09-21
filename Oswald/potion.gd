extends Area2D

func _body_entered(body):
	queue_free()
	Score.player_pickup_potion()

