extends Node2D

@export var start_health: int = 1000

@onready var health: float = start_health

func _on_turret_hurt_box_body_entered(enemy: Enemy) -> void:
  # we should only get enemies here (because of collision masks)
  take_damage(enemy)
  enemy.attack_player()

func take_damage(enemy: Enemy):
  health -= enemy.stats.damage
  Events.player_damaged.emit(health)
  if (health <= 0):
    Events.player_died.emit()
    queue_free()
