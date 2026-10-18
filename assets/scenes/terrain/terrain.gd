class_name Terrain extends Node2D

@onready var level_data = %LevelData

func fill_cell_at(global_pos: Vector2, atlas_coords: Vector2i) -> void:
  var debris_location = level_data.local_to_map(level_data.to_local(global_pos))
  # we might have to do some scanning of the nearest cells to find a spot for the
  # chunk if they just disappear
  if !level_data.get_cell_tile_data(debris_location):
    level_data.set_cell(debris_location, 0, atlas_coords)
