extends Node

var levels = [
	"res://test_scene/test_scene.tscn",
	"res://test_scene/Scene2.tscn",
	"res://test_scene/Scene3.tscn",
	"res://test_scene/Win.tscn"
]

var enemiesInLevel = [
	4,
	30,
	6
]

var curr = -1

func getTotalEnemiesInLevel():
	return enemiesInLevel[curr]
	
func getNextLevel():
	curr += 1
	return levels[curr]
	
	
func loadCurrentLevel():
	Score.reset_enemy_kills()
	Score.time = 60
	get_tree().change_scene_to_file(levels[curr])
	if enemiesInLevel[curr] >= 5:
		Score.time = 180
		
func loadNextLevel():
	Score.reset_enemy_kills()
	Score.level += 1
	Score.time = 60
	get_tree().change_scene_to_file(getNextLevel())
	if enemiesInLevel[curr] >= 5:
		Score.time = 180
	
	
func loadFirstLevel():
	curr = -1
	loadNextLevel()
