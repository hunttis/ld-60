extends Sprite2D

enum Direction { UP = 1, DOWN = -1 }

const ANGLE_MOD_SPEED = 75
const MIN_ANGLE = 5
const MAX_ANGLE = 80
const FINESSE_ANGLE_MULTIPLIER = .5
const MIN_POWER = .1
const MAX_POWER = .999
const RELOAD_DELAY = 1.0
const CHARGE_SPEED_MULTIPLIER = .75

signal angle_changed(angle: float)
signal power_changed(power: float)
signal shoot(angle: float, power: float)

var angle: float = 45
var shot_power: float = 0
var shot_delay: float = RELOAD_DELAY
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

  if shot_delay > 0:
    shot_delay = max(shot_delay - delta, 0)
    if shot_delay == 0:
      Events.reload_complete.emit()

  if Input.is_action_pressed("lower_cannon_angle") && angle > MIN_ANGLE:
    var angle_change = delta
    if Input.is_action_pressed("angle_finesse_modifier"):
      angle_change *= FINESSE_ANGLE_MULTIPLIER
    change_cannon_angle(Direction.DOWN, angle_change)
  if Input.is_action_pressed("raise_cannon_angle") && angle < MAX_ANGLE:
    var angle_change = delta
    if Input.is_action_pressed("angle_finesse_modifier"):
      angle_change *= FINESSE_ANGLE_MULTIPLIER
    change_cannon_angle(Direction.UP, angle_change)
  if Input.is_action_just_pressed("shoot"):
    shot_power = MIN_POWER
  if Input.is_action_pressed("shoot") && shot_delay == 0 && shot_power < MAX_POWER:
    shot_power = min(shot_power + delta * CHARGE_SPEED_MULTIPLIER, MAX_POWER)
    power_changed.emit(shot_power)
  if Input.is_action_just_released("shoot") && shot_delay == 0:
    shoot.emit(angle, shot_power)
    shot_delay = RELOAD_DELAY
    Events.reloading.emit()

func change_cannon_angle(dir: Direction, delta: float):
  angle += dir * delta * ANGLE_MOD_SPEED
  rotation_degrees = 0 - angle
  angle_changed.emit(angle)
