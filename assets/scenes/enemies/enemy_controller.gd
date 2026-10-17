class_name EnemyController extends Node

signal enemy_died(enemy: Enemy)

@export_group("Setup")
@export var spawner: EnemySpawner
@export var walker_spawn: Node2D
@export var flyer_spawn: Node2D
@export_range(0.0, 1.0) var speed_variance: float = 0.15

@export_group("Basic Enemy", "basic_")
@export var basic_speed: float = 400.0
@export var basic_max_health: float = 10.0
@export var basic_jump_strength: float = 100.0
@export var basic_point_value: int = 1
@export var basic_sprite_frames: SpriteFrames = preload("res://assets/scenes/enemies/sprites/basic_enemy_sprite_frames.tres")
@export_subgroup("Spawn Settings", "basic_spawn_")
@export_range(0, 50, 1) var basic_spawn_x_variance: float = 0.0
@export_range(0, 50, 1) var basic_spawn_y_variance: float = 0.0

@export_group("Light Flying Enemy", "light_flying_")
@export var light_flying_speed: float = 500.0
@export var light_flying_max_health: float = 5.0
@export var light_flying_point_value: int = 2
@export var light_flying_sprite_frames: SpriteFrames = preload("res://assets/scenes/enemies/sprites/light_flying_enemy_sprite_frames.tres")
@export_subgroup("Spawn Settings", "light_flying_spawn_")
@export_range(0, 50, 1) var light_flying_spawn_x_variance: float = 0.0
@export_range(0, 50, 1) var light_flying_spawn_y_variance: float = 20.0

@export_group("Dark Flying Enemy", "dark_flying_")
@export var dark_flying_speed: float = 350.0
@export var dark_flying_max_health: float = 15.0
@export var dark_flying_point_value: int = 3
@export var dark_flying_sprite_frames: SpriteFrames = preload("res://assets/scenes/enemies/sprites/dark_flying_enemy_sprite_frames.tres")
@export_subgroup("Spawn Settings", "dark_flying_spawn_")
@export_range(0, 50, 1) var dark_flying_spawn_x_variance: float = 0.0
@export_range(0, 50, 1) var dark_flying_spawn_y_variance: float = 20.0

@export_group("Big Enemy", "big_")
@export var big_speed: float = 250.0
@export var big_max_health: float = 40.0
@export var big_jump_strength: float = 100.0
@export var big_point_value: int = 5
@export var big_sprite_frames: SpriteFrames = preload("res://assets/scenes/enemies/sprites/big_enemy_sprite_frames.tres")
@export_subgroup("Spawn Settings", "big_spawn_")
@export_range(0, 50, 1) var big_spawn_x_variance: float = 0.0
@export_range(0, 50, 1) var big_spawn_y_variance: float = 0.0

func _ready() -> void:
  spawner.controller = self

func spawn_basic_enemy() -> void:
  _add_enemy(spawner.spawn_basic_enemy())

func spawn_dark_flying_enemy() -> void:
  _add_enemy(spawner.spawn_dark_flying_enemy())

func spawn_light_flying_enemy() -> void:
  _add_enemy(spawner.spawn_light_flying_enemy())

func spawn_big_enemy() -> void:
  _add_enemy(spawner.spawn_big_enemy())

func _add_enemy(enemy: Enemy) -> void:
  add_child(enemy)
  enemy.on_death.connect(_on_enemy_death.bind(enemy))

func _on_enemy_death(enemy: Enemy) -> void:
  enemy_died.emit(enemy)
  Events.enemy_died.emit(enemy.point_value, enemy.global_position)
