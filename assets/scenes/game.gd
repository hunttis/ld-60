extends Node2D

@export var projectile_scene: PackedScene

@onready var angle_value_label = $CannonParametersPanel/AngleValue
@onready var shot_power_label = $CannonParametersPanel/PowerValue
@onready var cannon = $Player/Cannon
@onready var tilemap_layer = $Terrain/LevelData

@export var shoot_speed: float = 250.0

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

    get_tree().current_scene.add_child(cannonball)
    cannonball.global_position = cannon.global_position
    var direction = Vector2(angle/100, -angle/100)
    cannonball.linear_velocity = direction * shoot_speed * power
