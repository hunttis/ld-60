extends Node2D

var lifetime: float

func _ready() -> void:
  lifetime = $GPUParticles2D.lifetime
  $GPUParticles2D.emitting = true

func _process(delta):
  if !$GPUParticles2D.emitting:
    lifetime -= delta
    if lifetime < 0:
      queue_free()
