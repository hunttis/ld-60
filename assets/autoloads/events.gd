extends Node

signal go_to_options
signal go_to_menu
signal go_to_game
signal go_to_game_over

signal set_start_values

signal player_died
signal enemy_died(enemy: Enemy)

signal wave_started
signal wave_complete

signal create_particle_fx(coords: Vector2, type: Global.PARTICLE_FX_TYPE)
