extends Node2D

var activation_cooldown = 0.5
var paused: bool = false

func _ready() -> void:
  visible = false
  Events.toggle_pause_mode.connect(toggle_pause)

func toggle_pause(paused: bool):
  self.paused = paused
  if paused:
    visible = true
  else:
    visible = false

func _process(delta: float) -> void:
  activation_cooldown -= delta

  if !paused || activation_cooldown > 0:
    return

  if Input.is_action_just_pressed("ui_select"):
    activation_cooldown = 0.5
    Events.toggle_pause_mode.emit(false)
  elif Input.is_action_just_pressed("ui_cancel"):
    activation_cooldown = 0.5
    Events.go_to_menu.emit()
