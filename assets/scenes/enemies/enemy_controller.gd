class_name EnemyController extends Node

signal enemy_died(enemy: Enemy)

@export var spawner: EnemySpawner
@export var walker_spawn: Node2D
@export var flyer_spawn: Node2D
@export_range(0,50,1) var flyer_spawn_variance: int = 20
@export_range(0.0, 1.0) var speed_variance: float = 0.15

@export_group("Basic Enemy")
@export var basic_speed: float = 400.0
@export var basic_max_health: float = 10.0
@export var basic_sprite_frames: SpriteFrames = preload("res://assets/scenes/enemies/sprites/basic_enemy_sprite_frames.tres")

@export_group("Light Flying Enemy")
@export var light_flying_speed: float = 500.0
@export var light_flying_max_health: float = 5.0
@export var light_flying_sprite_frames: SpriteFrames = preload("res://assets/scenes/enemies/sprites/light_flying_enemy_sprite_frames.tres")

@export_group("Dark Flying Enemy")
@export var dark_flying_speed: float = 350.0
@export var dark_flying_max_health: float = 15.0
@export var dark_flying_sprite_frames: SpriteFrames = preload("res://assets/scenes/enemies/sprites/dark_flying_enemy_sprite_frames.tres")

func _ready() -> void:
  spawner.controller = self

func spawn_basic_enemy() -> void:
  _add_enemy(spawner.spawn_basic_enemy())

func spawn_dark_flying_enemy() -> void:
  _add_enemy(spawner.spawn_dark_flying_enemy())

func spawn_light_flying_enemy() -> void:
  _add_enemy(spawner.spawn_light_flying_enemy())

func _add_enemy(enemy: Enemy) -> void:
  add_child(enemy)
  enemy.on_death.connect(_on_enemy_death.bind(enemy))

func _on_enemy_death(enemy: Enemy) -> void:
  enemy_died.emit(enemy)
