class_name EnemyController extends Node

signal enemy_died(enemy: Enemy)

@export_group("Setup")
@export var walker_spawn: Node2D
@export var flyer_spawn: Node2D
@export_range(0.0, 1.0) var speed_variance: float = 0.15

@export_group("Enemy Types")
@export var basic_enemy: EnemyStats = preload("res://assets/scenes/enemies/stats/basic_enemy_stats.tres")
@export var light_flying_enemy: EnemyStats = preload("res://assets/scenes/enemies/stats/light_flying_enemy_stats.tres")
@export var dark_flying_enemy: EnemyStats = preload("res://assets/scenes/enemies/stats/dark_flying_enemy_stats.tres")
@export var big_enemy: EnemyStats = preload("res://assets/scenes/enemies/stats/big_enemy_stats.tres")

@onready var spawner: EnemySpawner = $EnemySpawner

var enemy_count = 0

func _ready() -> void:
  spawner.controller = self

func spawn_basic_enemy() -> void:
  spawn(Global.ENEMY_TYPE.BASIC)

func spawn_dark_flying_enemy() -> void:
  spawn(Global.ENEMY_TYPE.FLYER_DARK)

func spawn_light_flying_enemy() -> void:
  spawn(Global.ENEMY_TYPE.FLYER_LIGHT)

func spawn_big_enemy() -> void:
  spawn(Global.ENEMY_TYPE.BIG)

func spawn_stats(stats: EnemyStats) -> void:
  _add_enemy(spawner.spawn(stats))

func spawn(enemy_type: Global.ENEMY_TYPE) -> void:
  _add_enemy(spawner.spawn(get_stats(enemy_type)))

func get_stats(enemy_type: Global.ENEMY_TYPE) -> EnemyStats:
  match enemy_type:
    Global.ENEMY_TYPE.BASIC:
      return basic_enemy
    Global.ENEMY_TYPE.BIG:
      return big_enemy
    Global.ENEMY_TYPE.FLYER_LIGHT:
      return light_flying_enemy
    Global.ENEMY_TYPE.FLYER_DARK:
      return dark_flying_enemy
  return null

func _add_enemy(enemy: Enemy) -> void:
  add_child(enemy)
  enemy_count += 1
  enemy.on_death.connect(_on_enemy_death.bind(enemy))

func _on_enemy_death(enemy: Enemy) -> void:
  enemy_died.emit(enemy)
  Events.enemy_died.emit(enemy.point_value, enemy.global_position)
  enemy_count -= 1
  if enemy_count == 0:
    Events.wave_complete.emit()
