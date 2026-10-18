class_name WaveManager extends Node


@export var game_manager: GameManager
@export var enemy_controller: EnemyController

const BASE_POINTS = 15

var wave: int = 1
var points: int = 0

var spawn_cooldown: Timer

func _ready():
  Events.wave_complete.connect(_next_wave)
  spawn_cooldown = Timer.new()
  spawn_cooldown.one_shot = true
  add_child(spawn_cooldown)
  spawn_cooldown.timeout.connect(_spawn)
  _start_wave()

func _get_spawn_cooldown() -> float:
  var wave_factor = maxf(1.0 - (wave - 3) * 0.07, 0.25)
  return randf_range(0.5, 1.5) * wave_factor

func _calculate_wave_points() -> void:
  points = round(BASE_POINTS + pow(BASE_POINTS, 1 + wave/10.0))

func _spawn() -> void:
  var picked = _pick_enemy()
  if !picked:
    return

  print("Spawning ", picked.name,". Wave ", wave)
  enemy_controller.spawn(picked)
  spawn_cooldown.start(randf_range(0.5,1.5))

func _pick_enemy() -> Variant:
  var valid = []
  for type in Global.ENEMY_TYPE.values():
    var stats: EnemyStats = enemy_controller.get_stats(type as Global.ENEMY_TYPE)
    if stats.unlocks_at_wave <= wave && points >= stats.point_value:
      valid.push_back(stats)

  if valid.size() == 0:
    return null

  var selected: EnemyStats = valid.pick_random()
  if !selected:
    return null

  points -= selected.point_value
  return selected

func _start_wave():
  _calculate_wave_points()
  spawn_cooldown.start(randf_range(0.5,1.5))
  Events.wave_started.emit()

func _next_wave() -> void:
  wave += 1
  _start_wave()
