extends Node2D

@export var projectile_scene: PackedScene

@onready var angle_value_label = $CannonParametersPanel/AngleValue
@onready var shot_power_label = $CannonParametersPanel/PowerValue
@onready var cannon = $Player/Cannon
@onready var player = $Player
@onready var tilemap_layer = $Terrain/LevelData

@export var shoot_speed: float = 1000

var paused = false

func _ready() -> void:
  cannon.angle_changed.connect(update_ui_angle)
  cannon.power_changed.connect(update_ui_power)
  cannon.shoot.connect(shoot)

  Events.player_died.connect(end_game)
  Events.toggle_pause_mode.connect(toggle_pause)

  Events.set_start_values.emit()

func _process(delta: float) -> void:
  if paused:
    return
  if Input.is_action_just_pressed("ui_cancel"):
    print("Pausing")
    Events.toggle_pause_mode.emit(true)

func toggle_pause(paused: bool):
  self.paused = paused

func update_ui_angle(angle: float):
  angle_value_label.text = str("%.1f" % angle)

func update_ui_power(power: float):
  if power == 0:
    shot_power_label.text = "-"
  else:
    shot_power_label.text = str("%.0f" % (power * 1000))

func shoot(angle: float, power: float) -> void:
  if paused:
    return
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
  update_ui_power(0)

func end_game():
  Events.go_to_game_over.emit()
