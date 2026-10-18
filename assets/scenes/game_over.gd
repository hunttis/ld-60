extends Node2D

func _process(_delta: float) -> void:
  if Input.is_action_just_pressed("shoot"):
    Events.go_to_menu.emit()
