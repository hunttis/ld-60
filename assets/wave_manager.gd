class_name WaveManager extends Node

@export var game_manager: GameManager

const BASE_POINTS = 15

var wave: float = 1
var points: int = 0

var spawn_cooldown: Timer

func _ready():
  spawn_cooldown = Timer.new()
  spawn_cooldown.one_shot = true
  add_child(spawn_cooldown)
  spawn_cooldown.timeout.connect(spawn)

func calculate_wave_points() -> void:
  points = round(BASE_POINTS + pow(BASE_POINTS, 1 + wave/10))

func spawn() -> void:
  if points == 0:
    return
  
  
