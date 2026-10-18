class_name Enemy extends CharacterBody2D

signal on_damage_taken(damage: float)
signal on_death()
signal on_attack()
signal before_move(delta: float)

@onready var sprite = $Sprite
@onready var hurtbox = $EnemyHurtbox/Hurtbox
@onready var collision = $Collision

@export var stats: EnemyStats

var speed: float
var point_value: int
var health: float
var current_speed: float
var stop: bool = false

func _ready():
  health = stats.max_health
  point_value = stats.point_value
  if speed == 0:
    speed = stats.speed
  sprite.sprite_frames = stats.sprite_frames
  sprite.play("default")
  _fit_shapes_to_sprite()
  _add_components()

static func create(_stats: EnemyStats, _speed: float) -> Enemy:
  var enemy: Enemy = load("res://assets/scenes/enemies/enemy.tscn").instantiate()
  enemy.stats = _stats
  enemy.speed = _speed
  return enemy

func _fit_shapes_to_sprite() -> void:
  var size: Vector2 = stats.sprite_frames.get_frame_texture("default", 0).get_size()
  var collider_shape = RectangleShape2D.new()
  var hurtbox_shape = RectangleShape2D.new()
  collider_shape.size = size
  hurtbox_shape.size = size
  collision.shape = collider_shape
  hurtbox.shape = hurtbox_shape

func _add_components() -> void:
  add_child(EnemyMoveLeftComponent.new())
  if stats.has_gravity:
    add_child(GravityComponent.new())
  if stats.jump_strength > 0:
    add_child(EnemyJumpComponent.new(stats.jump_strength))

func take_damage(damage: float) -> void:
  health -= damage
  on_damage_taken.emit(damage)

  if health <= 0:
    die()

func die() -> void:
  on_death.emit()
  queue_free()

func attack_player() -> void:
  on_attack.emit()
  queue_free()

func _physics_process(delta):
  before_move.emit(delta)
  move_and_slide()

func _on_enemy_hurtbox_body_entered(projectile: Node2D) -> void:
  # only matches collision layer 4 (projectiles)
  var cannonball_speed = projectile.linear_velocity.length()
  take_damage(cannonball_speed / 20)
  projectile.health -= 5
