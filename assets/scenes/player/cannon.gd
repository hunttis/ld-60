extends Sprite2D

enum Direction { UP = 1, DOWN = -1 }

const ANGLE_MOD_SPEED = 75
const MIN_ANGLE = 5
const MAX_ANGLE = 80
const MIN_POWER = 1
const MAX_POWER = 9

signal angle_changed(angle: float)
signal power_changed(power: int)
signal shoot(angle: float, power: int)

var angle: float = 45
var shot_power: int = 5
var paused: bool = false

func _init() -> void:
  rotation_degrees = 0 - angle

func _ready() -> void:
  Events.set_start_values.connect(emit_start_values)
  Events.toggle_pause_mode.connect(toggle_pause)

func toggle_pause(paused: bool):
  self.paused = paused

func emit_start_values() -> void:
  angle_changed.emit(angle)
  power_changed.emit(shot_power)

func _process(delta: float) -> void:
  if paused:
    return
  if Input.is_action_pressed("lower_cannon_angle") && angle > MIN_ANGLE:
    change_cannon_angle(Direction.DOWN, delta)
  if Input.is_action_pressed("raise_cannon_angle") && angle < MAX_ANGLE:
    change_cannon_angle(Direction.UP, delta)
  if Input.is_action_just_pressed("increase_shot_power") && shot_power < MAX_POWER:
    shot_power += 1
    power_changed.emit(shot_power)
  if Input.is_action_just_pressed("decrease_shot_power") && shot_power > MIN_POWER:
    shot_power -= 1
    power_changed.emit(shot_power)
  if Input.is_action_just_pressed("shoot"):
    shoot.emit(angle, shot_power)

func change_cannon_angle(dir: Direction, delta: float):
  angle += dir * delta * ANGLE_MOD_SPEED
  rotation_degrees = 0 - angle
  angle_changed.emit(angle)
