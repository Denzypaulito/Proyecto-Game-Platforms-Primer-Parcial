extends CharacterBody2D

@export var shoot_cd: float = 2.0
@export var max_hp: float = 10.0
@export var move_speed: float = 80.0
@export var move_dir_refresh_t: float = 2.0

@onready var hp: float = max_hp
@onready var original_color = $AnimatedSprite2D.modulate  # Color original del personaje


var shoot_time: float = 0.0
var move_dir_time: float = 0.0
var curr_pattern: int = 0
var move_dir: Vector2 = Vector2(1.0, 0.0)
var red_color = Color(1, 0, 0, 1)  # Color rojo
var dead = false
signal death

func _process(delta: float) -> void:
	shoot_time += delta
	if shoot_time >= shoot_cd:
		$FireBall.play()
		shoot_time -= shoot_cd
		$Patterns.get_child(curr_pattern).fire_pattern()
		curr_pattern = (curr_pattern + 1)%$Patterns.get_child_count()
	
	move_dir_time += delta
	if move_dir_time >= move_dir_refresh_t:
		move_dir_time -= move_dir_refresh_t
		move_dir = Vector2(1.0, 0.0).rotated(randf()*2.0*PI)
	
	velocity = move_dir*move_speed
	move_and_slide()

func call_death_signal():
	death.emit()

func restore():
	$AnimatedSprite2D.modulate = original_color
	
func damage(d: float) -> void:
	hp -= d
	var tween = get_tree().create_tween()
	tween.tween_property($AnimatedSprite2D, "modulate", Color.BLUE, 0.2)
	tween.tween_callback(restore)
	if hp <= 0.0 and not dead:
		dead = true
		tween.tween_property($AnimatedSprite2D, "scale", Vector2(), 0.2)
		tween.tween_callback(queue_free)
		$"/root/Score".slime_dead()
		$"/root/Score".on_score()
		call_death_signal() 

