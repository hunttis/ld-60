class_name PathFollowComponent extends EnemyComponent

@export var path: Path2D

@export var lookahead: float = 20.0

func _connect_signals() -> void:
  enemy.before_move.connect(_follow_path)

func _follow_path(delta: float) -> void:
  if !path:
    return
  
  var local_pos = path.to_local(enemy.global_position)
  var progress = path.curve.get_closest_offset(local_pos)
  var offset = clamp(progress+lookahead, progress, path.curve.get_baked_length())
  var target = path.to_global(path.curve.sample_baked(offset))
  var direction = enemy.global_position.direction_to(target)
  enemy.velocity = direction * enemy.speed * delta
