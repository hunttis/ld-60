extends Node2D

@onready var angle_value_label = $CannonParametersPanel/AngleValue
@onready var shot_power_label = $CannonParametersPanel/PowerValue
@onready var cannon = $Player/Cannon

func _ready() -> void:
  cannon.angle_changed.connect(func(angle: float):
    angle_value_label.text = str("%.1f" % angle)
  )
  cannon.power_changed.connect(func(power: int):
    shot_power_label.text = str(power)
  )

  cannon.emit_start_values()
