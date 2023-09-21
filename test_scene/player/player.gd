extends CharacterBody2D

@export var speed: float = 400.0
@export var weapon_cooldowns: Array[float] = [0.3, 0.1, 1.0]

var selected_weapon: int = 0
var time_to_shoot: float = 0.0
var tiempo_de_duracion = 1.0
#var tween 
var tween_duration = 0.5  # Duración de la animación en segundos
var red_color = Color(1, 0, 0, 1)  # Color rojo
@onready var original_color = $AnimatedSprite2D.modulate  # Color original del personaje

#func _ready():
	#tween = get_tree().create_tween()
	#tween.tween_property($AnimatedSprite2D, "modulate", red_color, 0.5).set_trans(Tween.TRANS_LINEAR)
	#tween.tween_callback(restore)
	#tween.stop()

	
func shoot(direction: Vector2) -> void:
	var shooter = $Weapons.get_child(selected_weapon)
	shooter.rotation = Vector2(1, 0).angle_to(direction)
	shooter.fire_pattern()


func select_next_weapon() -> void:
	selected_weapon = (selected_weapon + 1) % $Weapons.get_child_count()


func select_prev_weapon() -> void:
	selected_weapon = (selected_weapon - 1 + $Weapons.get_child_count()) % $Weapons.get_child_count()


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("shoot") and time_to_shoot <= 0.0:
		shoot(get_global_mouse_position() - global_position)
		time_to_shoot = weapon_cooldowns[selected_weapon]
		$Shot.play()
	time_to_shoot -= delta
	
	if Input.is_action_just_pressed("weapon_next"):
		select_next_weapon()
	if Input.is_action_just_pressed("weapon_prev"):
		select_prev_weapon()
	var direction: Vector2 = Vector2(
		int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left")),
		int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	)
	
	velocity = speed * direction
	move_and_slide()
	update_visuals(direction)


func update_visuals(move_dir: Vector2) -> void:
	$AnimatedSprite2D.flip_h = move_dir.x < 0
	if move_dir.length() > 0:
		$AnimatedSprite2D.play("run")
	else:
		$Caminar.play()
		$AnimatedSprite2D.play("idle")

func restore():
	$AnimatedSprite2D.modulate = original_color
	#tween.stop()
	
func damage(dmg: float) -> void:
	$"/root/Score".health -= dmg
	#if tween.is_running():
		#tween.stop()
	# Comprueba si el jugador ha perdido toda su vida
	if $"/root/Score".health <= 0:
		# Aquí puedes agregar lógica para manejar la muerte del jugador, como reiniciar el nivel o mostrar una pantalla de Game Over.
		# Por ejemplo:
		#get_tree().reload_current_scene()
		$"/root/Score".on_player_death()
	else:
		#tween.play()
		var tween = get_tree().create_tween()
		tween.tween_property($AnimatedSprite2D, "modulate", red_color, 0.01).set_trans(Tween.TRANS_LINEAR)
		tween.tween_interval(0.2)
		tween.tween_callback(restore)
				
