class_name EnemySpawner extends Node

# Set by the EnemyController, which holds all the enemy settings
var controller: EnemyController

func spawn_basic_enemy() -> Enemy:
  var enemy := _create(controller.basic_speed, controller.basic_max_health, controller.basic_sprite_frames, controller.basic_point_value)
  enemy.add_child(GravityComponent.new())
  enemy.add_child(EnemyJumpComponent.new(controller.basic_jump_strength))
  return _spawn(enemy, _add_variance(controller.walker_spawn.global_position, controller.basic_spawn_x_variance, controller.basic_spawn_y_variance))

func spawn_light_flying_enemy() -> Enemy:
  var enemy := _create(controller.light_flying_speed, controller.light_flying_max_health, controller.light_flying_sprite_frames, controller.light_flying_point_value)
  return _spawn(enemy, _add_variance(controller.flyer_spawn.global_position, controller.light_flying_spawn_x_variance, controller.light_flying_spawn_y_variance))

func spawn_dark_flying_enemy() -> Enemy:
  var enemy := _create(controller.dark_flying_speed, controller.dark_flying_max_health, controller.dark_flying_sprite_frames, controller.dark_flying_point_value)
  return _spawn(enemy, _add_variance(controller.flyer_spawn.global_position, controller.dark_flying_spawn_x_variance, controller.dark_flying_spawn_y_variance))

func _add_variance(spawn_position: Vector2, x_variance: float = 0, y_variance: float = 0) -> Vector2:
  var spawn_x = spawn_position.x + randf_range(-x_variance, x_variance)
  var spawn_y = spawn_position.y + randf_range(-y_variance, y_variance)
  return Vector2(spawn_x, spawn_y)

func _create(speed: float, max_health: float, sprite_frames: SpriteFrames, point_value: int) -> Enemy:
  var variance := controller.speed_variance
  var enemy := Enemy.create(speed * randf_range(1.0 - variance, 1.0 + variance), max_health)
  enemy.sprite_frames = sprite_frames
  enemy.point_value = point_value
  var move_component = EnemyMoveLeftComponent.new()
  enemy.add_child(move_component)
  return enemy

func _spawn(enemy: Enemy, spawn_point: Vector2) -> Enemy:
  enemy.global_position = spawn_point
  return enemy
