class_name Enemy extends CharacterBody2D

signal on_damage_taken(damage: float)
signal on_death()
signal before_move(delta: float)


@export var speed: float = 400.0
@export var max_health: float

var health: float
var current_speed: float

func _ready():
  health = max_health

static func create(_speed: float, _max_health: float, _armor: float) -> Enemy:
  var enemy: Enemy = load("res://assets/scenes/enemies/enemy.tscn").instantiate()
  enemy.speed = _speed
  enemy.max_health = _max_health
  enemy.health = _max_health
  return enemy

func take_damage(damage: float) -> void:
  health -= damage
  on_damage_taken.emit(damage)
  
  if health <= 0:
    die()

func die() -> void:
  print("should die")
  on_death.emit()
  queue_free()

func _physics_process(delta):
  before_move.emit(delta)
  move_and_slide()
