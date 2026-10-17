class_name Enemy extends CharacterBody2D

signal on_damage_taken(damage: float, enemy: Enemy)
signal on_death(enemy: Enemy)
signal before_move(delta: float, enemy: Enemy)


var speed: float = 400.0
var max_health: float = 1

var health: float
var current_speed: float

static func create(_speed: float, _max_health: float, _armor: float) -> Enemy:
  var enemy: Enemy = load("res://assets/scenes/enemies/enemy.tscn").instantiate()
  enemy.speed = _speed
  enemy.max_health = _max_health
  enemy.health = _max_health
  return enemy

func take_damage(damage: float) -> void:
  health -= damage
  on_damage_taken.emit(damage, self)
  
  if health <= 0:
    die()

func die() -> void:
  on_death.emit(self)
  queue_free()

func _physics_process(delta):
  # Add the gravity.
  if not is_on_floor():
    velocity += get_gravity() * delta

  before_move.emit(delta, self)
  move_and_slide()
