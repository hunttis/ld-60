extends Node2D

@export var start_health: float = 1000

@onready var health: float = start_health

func _on_turret_hurt_box_body_entered(body: Enemy) -> void:
  # we should only get enemies here (because of collision masks)
  body.point_value *= -2
  take_damage(body)
  body.die()

func take_damage(enemy: Enemy):
  # replace with separate property for enemies ("damage") later
  health -= enemy.stats.max_health
  if (health <= 0):
    Events.player_died.emit()
    queue_free()
