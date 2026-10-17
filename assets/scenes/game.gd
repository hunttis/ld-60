extends Node2D

@export var projectile_scene: PackedScene

@onready var angle_value_label = $CannonParametersPanel/AngleValue
@onready var shot_power_label = $CannonParametersPanel/PowerValue
@onready var cannon = $Player/Cannon
@onready var tilemap_layer = $Terrain/LevelData

@export var shoot_speed: float = 90

func _ready() -> void:
  cannon.angle_changed.connect(func(angle: float):
    angle_value_label.text = str("%.1f" % angle)
  )
  cannon.power_changed.connect(func(power: int):
    shot_power_label.text = str(power)
  )
  cannon.shoot.connect(shoot)

  cannon.emit_start_values()

func shoot(angle: float, power: int) -> void:
  var cannonball = projectile_scene.instantiate() as RigidBody2D
  cannonball.tilemap_layer = tilemap_layer

  var angle_radians: float = deg_to_rad(angle)
  var direction: Vector2 = Vector2(
      cos(angle_radians),
      -sin(angle_radians)
  )

  get_tree().current_scene.add_child(cannonball)
  cannonball.global_position = cannon.global_position
  cannonball.linear_velocity = direction * shoot_speed * power
