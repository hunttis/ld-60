class_name EnemySpawner extends Node

# Set by the EnemyController, which holds the spawn points and shared settings
var controller: EnemyController

func spawn(stats: EnemyStats) -> Enemy:
  var variance := controller.speed_variance
  var enemy := Enemy.create(stats, stats.speed * randf_range(1.0 - variance, 1.0 + variance))
  enemy.global_position = _add_variance(_get_spawn_origin(stats), stats.spawn_x_variance, stats.spawn_y_variance)
  return enemy

func _get_spawn_origin(stats: EnemyStats) -> Vector2:
  match stats.spawn_point:
    EnemyStats.SpawnPoint.FLYER:
      return controller.flyer_spawn.global_position
  return controller.walker_spawn.global_position

func _add_variance(spawn_position: Vector2, x_variance: float = 0, y_variance: float = 0) -> Vector2:
  var spawn_x = spawn_position.x + randf_range(-x_variance, x_variance)
  var spawn_y = spawn_position.y + randf_range(-y_variance, y_variance)
  return Vector2(spawn_x, spawn_y)
