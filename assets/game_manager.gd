class_name GameManager extends Node

var points: int = 0
var wave: int = 1
@onready var points_value = $"../CannonParametersPanel/PointsLabel/PointsValue"


func _ready():
  Events.enemy_died.connect(_on_enemy_died)
  points_value.text = str(points)

func _spawn_floating_text(text: String, position: Vector2) -> void:
  var floater = FloatingTextComponent.create()
  add_child(floater)
  floater.play(text, position)

func _add_points(value: int) -> void:
  points += value
  points_value.text = str(points)

func _on_enemy_died(value: int, position: Vector2) -> void:
  _spawn_floating_text(str("+",value), position)
  _add_points(value)
