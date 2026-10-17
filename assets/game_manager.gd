extends Node

var points: int = 0
@onready var points_value = $"../CannonParametersPanel/PointsLabel/PointsValue"


func _ready():
  Events.enemy_died.connect(_on_enemy_died)
  points_value.text = str(points)

func _on_enemy_died(value: int, position: Vector2) -> void:
  var floater = FloatingTextComponent.create()
  add_child(floater)
  floater.play(str("+",value), position)
  points += value
  points_value.text = str(points)
