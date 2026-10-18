class_name FxManager extends Node

var dirt_explosion_fx = preload("res://assets/scenes/fx/dirt_explosion_fx.tscn")

func _ready() -> void:
  Events.create_particle_fx.connect(create_particle_fx)

func create_particle_fx(coords: Vector2, type: Global.PARTICLE_FX_TYPE):
  var created_fx: Node2D
  match type:
    Global.PARTICLE_FX_TYPE.DIRT:
      created_fx = dirt_explosion_fx.instantiate()

  created_fx.global_position = coords
  add_child(created_fx)
