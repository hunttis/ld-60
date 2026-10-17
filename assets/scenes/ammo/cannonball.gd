extends RigidBody2D

var tilemap_layer: TileMapLayer
var health = 0.1
@export var destruction_radius: float = 6

func _physics_process(_delta: float) -> void:
  var center = tilemap_layer.to_local(global_position)
  var center_coords = tilemap_layer.local_to_map(center)
  var tile_size = Vector2i(4, 4)
  var radius_in_tiles = ceili(destruction_radius / minf(tile_size.x, tile_size.y))

  for x in range(center_coords.x - radius_in_tiles, center_coords.x + radius_in_tiles + 1):
    for y in range(center_coords.y - radius_in_tiles, center_coords.y + radius_in_tiles + 1):
      var coords = Vector2i(x, y)

      if tilemap_layer.get_cell_source_id(coords) == -1:
        continue

      # Get the center of this tile in local coordinates.
      var tile_center = tilemap_layer.map_to_local(coords)

      # Destroy only tiles inside the circular radius.
      if tile_center.distance_to(center) <= destruction_radius:
        tilemap_layer.erase_cell(coords)
        health -= 0.05
        linear_velocity *= .75

  if health < 0:
    queue_free()
