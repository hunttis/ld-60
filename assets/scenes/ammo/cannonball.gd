extends RigidBody2D

var tilemap_layer: TileMapLayer
var health = 15
@export var destruction_radius: float = 6

func _physics_process(_delta: float) -> void:
  # game over, scene destruction might free tilemap before the cannonball
  if tilemap_layer == null: return

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
        var info = tilemap_layer.get_cell_tile_data(coords)
        var tile_hitpoints = info.get_custom_data("hitpoints")
        print("Hit tile HP: ", tile_hitpoints)
        if health > tile_hitpoints:
          tilemap_layer.erase_cell(coords)
        health -= tile_hitpoints
        linear_velocity *= .75
        Events.create_particle_fx.emit(global_position, Global.PARTICLE_FX_TYPE.DIRT)

  if health < 0:
    queue_free()
