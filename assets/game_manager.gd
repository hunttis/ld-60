class_name GameManager extends Node



@export var terrain: Terrain

@export var debris_min_impulse: float = 80.0
@export var debris_max_impulse: float = 180.0
@export_range(0, 180, 1) var debris_spread_degrees: float = 120.0

var points: int = 0
var wave: int = 1
@onready var points_value = $"../CannonParametersPanel/PointsLabel/PointsValue"


func _ready():
  Events.enemy_died.connect(_on_enemy_died)
  points_value.text = str(points)

func _spawn_floating_text(text: String, position: Vector2) -> void:
  var floater = FloatingTextComponent.create()
  add_child(floater)
  floater.play(text, position)

func _add_points(value: int) -> void:
  points += value
  points_value.text = str(points)

# Runs before the enemy is freed, so its position and values are still valid
func _on_enemy_died(enemy: Enemy) -> void:
  _spawn_floating_text(str("+",enemy.point_value), enemy.global_position)
  spawn_debris(enemy.global_position, enemy.stats.death_fill_cells, enemy.stats.death_chunk_type)
  _add_points(enemy.point_value)

func spawn_debris(from: Vector2, count: int, type: Debris.TerrainType) -> void:
  var half_spread := deg_to_rad(debris_spread_degrees / 2.0)
  for _n in range(count):
    var debris = Debris.create(type)
    terrain.add_child(debris)
    debris.terrain = terrain
    debris.global_position = from
    var direction := Vector2.UP.rotated(randf_range(-half_spread, half_spread))
    debris.apply_central_impulse(direction * randf_range(debris_min_impulse, debris_max_impulse))
