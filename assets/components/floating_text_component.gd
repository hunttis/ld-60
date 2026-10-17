class_name FloatingTextComponent extends Node2D

@onready var label = $Label

static func create() -> FloatingTextComponent:
  var floating: FloatingTextComponent = load("res://assets/components/floating_text_component.tscn").instantiate()
  return floating

func play(text: String, start_position: Vector2):
  label.text = text
  global_position = start_position
  var tween = create_tween()
  tween.set_parallel()
  tween.tween_property(self, "global_position", global_position + (Vector2.UP * 16), .3)\
  .set_ease(Tween.EASE_OUT)\
  .set_trans(Tween.TRANS_CUBIC)
  
  tween.tween_property(label, "modulate:a", 0, .3)\
  .set_ease(Tween.EASE_IN)\
  .set_trans(Tween.TRANS_CUBIC)
  tween.chain()
  
  tween.tween_callback(queue_free)
