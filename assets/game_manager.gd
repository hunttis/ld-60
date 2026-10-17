extends Node

func _ready():
  Events.enemy_died.connect(_on_enemy_died)

func _on_enemy_died(value: int, position: Vector2) -> void:
  var floater = FloatingTextComponent.create()
  add_child(floater)
  floater.play(str("+",value), position)
