class_name EnemyMoveLeftComponent extends EnemyComponent

func _connect_signals() -> void:
  enemy.before_move.connect(_move_to_target)

func _move_to_target(delta: float) -> void:
  enemy.velocity.x = -enemy.speed * delta
  pass
