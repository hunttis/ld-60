class_name Enemy extends CharacterBody2D

signal on_damage_taken(damage: float)
signal on_death()
signal before_move(delta: float)

@onready var sprite = $Sprite
@onready var hurtbox = $EnemyHurtbox/Hurtbox
@onready var collision = $Collision

@export var speed: float = 400.0
@export var max_health: float
@export var sprite_frames: SpriteFrames

var health: float
var current_speed: float

func _ready():
  health = max_health
  sprite.sprite_frames = sprite_frames
  sprite.play("default")
  var collider_shape = RectangleShape2D.new()
  var hurtbox_shape = RectangleShape2D.new()
  hurtbox_shape.size = sprite_frames.get_frame_texture("default",0).get_size()
  collider_shape.size = sprite_frames.get_frame_texture("default",0).get_size()
  hurtbox.shape = hurtbox_shape
  collision.shape = collider_shape

static func create(_speed: float, _max_health: float) -> Enemy:
  var enemy: Enemy = load("res://assets/scenes/enemies/enemy.tscn").instantiate()
  enemy.speed = _speed
  enemy.max_health = _max_health
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
