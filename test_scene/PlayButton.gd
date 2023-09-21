extends TextureButton

var no_mute = true


func _on_pressed():
	LevelManager.loadNextLevel()
	$"/root/Score/CanvasLayer".visible = true
	


func _on_pause_button_pressed():
	$"/root/MainMenu/CanvasLayer".visible = false
	$"/root/MainMenu/TileMap".visible = false
	$"/root/MainMenu/CanvasLayer2".visible = true


func _on_exit_button_pressed():
	$"/root/MainMenu/CanvasLayer".visible = true
	$"/root/MainMenu/TileMap".visible = true
	$"/root/MainMenu/CanvasLayer2".visible = false


func _on_mute_button_pressed():
	if not no_mute:
		no_mute = true
		$"CanvasLayer2/Mute Button".texture_normal = preload("res://test_scene/assets/v1.1 dungeon crawler 16X16 pixel pack/ui (new)/Volume.png")  
		$Song.volume_db = 0  
		
	else:
		no_mute = false
		$"CanvasLayer2/Mute Button".texture_normal = preload("res://test_scene/assets/v1.1 dungeon crawler 16X16 pixel pack/ui (new)/Volume Mute.png")  # Cambia la textura a la versión silenciada
		$Song.volume_db = -80 
