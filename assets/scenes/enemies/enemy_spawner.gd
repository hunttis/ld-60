class_name EnemySpawner extends Node

# Set by the EnemyController, which holds all the enemy settings
var controller: EnemyController

func spawn_basic_enemy() -> Enemy:
  var enemy := _create(controller.basic_speed, controller.basic_max_health, controller.basic_sprite_frames)
  enemy.add_child(GravityComponent.new())
  return _spawn(enemy, controller.walker_spawn.global_position)

func spawn_light_flying_enemy() -> Enemy:
  var enemy := _create(controller.light_flying_speed, controller.light_flying_max_health, controller.light_flying_sprite_frames)
  return _spawn_flyer(enemy)

func spawn_dark_flying_enemy() -> Enemy:
  var enemy := _create(controller.dark_flying_speed, controller.dark_flying_max_health, controller.dark_flying_sprite_frames)
  return _spawn_flyer(enemy)

func _create(speed: float, max_health: float, sprite_frames: SpriteFrames) -> Enemy:
  var variance := controller.speed_variance
  var enemy := Enemy.create(speed * randf_range(1.0 - variance, 1.0 + variance), max_health)
  enemy.sprite_frames = sprite_frames
  var move_component = EnemyMoveLeftComponent.new()
  enemy.add_child(move_component)
  return enemy

func _spawn_flyer(enemy: Enemy) -> Enemy:
  var spawn_pos_y = controller.flyer_spawn.global_position.y + randf_range(-controller.flyer_spawn_variance, controller.flyer_spawn_variance)
  return _spawn(enemy, Vector2(controller.flyer_spawn.global_position.x, spawn_pos_y))
  
func _spawn(enemy: Enemy, spawn_point: Vector2) -> Enemy:
  enemy.global_position = spawn_point
  return enemy
