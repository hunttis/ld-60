class_name EnemyHurtbox extends Area2D

func take_damage(damage: float) -> void:
  (get_parent() as Enemy).take_damage(damage)
