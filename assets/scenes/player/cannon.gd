extends Sprite2D

enum Direction { UP = 1, DOWN = -1 }

const ANGLE_MOD_SPEED = 75
const MIN_ANGLE = 5
const MAX_ANGLE = 80

signal angle_changed(angle: float)

var angle: float = 45

func _init() -> void:
  rotation_degrees = 0 - angle

func _process(delta: float) -> void:
  if Input.is_action_pressed("lower_cannon_angle") && angle > MIN_ANGLE:
    change_cannon_angle(Direction.DOWN, delta)
  if Input.is_action_pressed("raise_cannon_angle") && angle < MAX_ANGLE:
    change_cannon_angle(Direction.UP, delta)

func change_cannon_angle(dir: Direction, delta: float):
  angle += dir * delta * ANGLE_MOD_SPEED
  rotation_degrees = 0 - angle
  angle_changed.emit(angle)
