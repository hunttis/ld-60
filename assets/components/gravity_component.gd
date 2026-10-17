class_name GravityComponent extends EnemyComponent

func _connect_signals() -> void:
  enemy.before_move.connect(apply_gravity)

func apply_gravity(delta: float) -> void:
  if !enemy.is_on_floor():
    enemy.velocity += enemy.get_gravity() * delta
