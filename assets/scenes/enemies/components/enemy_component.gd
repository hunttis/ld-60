@abstract class_name EnemyComponent extends Node

var enemy: Enemy

@abstract func _connect_signals() -> void

func _enter_tree() -> void:
  enemy = get_parent() as Enemy
  _connect_signals()
