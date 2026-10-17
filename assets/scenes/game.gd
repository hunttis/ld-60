extends Node2D

@onready var angleValueLabel = $CannonParametersPanel/AngleValue
@onready var cannon = $Player/Cannon

func _ready() -> void:
  cannon.angle_changed.connect(func(angle: float):
    angleValueLabel.text = str("%.1f" % angle)
  )
