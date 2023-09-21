extends Node

var totalEnemies
var killedEnemies = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	totalEnemies = LevelManager.getTotalEnemiesInLevel()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_enemy_dead():
	killedEnemies += 1
	print(str(killedEnemies)+"/"+str(totalEnemies))
	Score.increment_enemy_kills()
	if killedEnemies == totalEnemies:
		LevelManager.loadNextLevel()
