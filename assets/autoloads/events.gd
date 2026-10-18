extends Node

signal go_to_options
signal go_to_menu
signal go_to_game

signal enemy_died(value: int, position: Vector2)

signal wave_started
signal wave_complete

signal create_particle_fx(coords: Vector2, type: Global.PARTICLE_FX_TYPE)
