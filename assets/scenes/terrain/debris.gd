class_name Debris extends RigidBody2D

const TILE_SIZE := 4

@export var max_lifetime: float = 2.5
@export var settle_speed: float = 15.0

@onready var sprite: Sprite2D = $sprite
@onready var ground_check: ShapeCast2D = $RayCast2D


var atlas_coords: Vector2i
var type: TerrainType
var settled: bool = false

var terrain: Terrain

enum TerrainType {
  STONE = 0,
  DIRT = 1,
  BEDROCK = 2
}

static func create(_type: TerrainType) -> Debris:
  var debris: Debris = load("res://assets/scenes/terrain/debris.tscn").instantiate()
  debris.type = _type
  return debris

func _ready():
  atlas_coords = Vector2i(randi_range(0, 3), type)
  sprite.region_rect = Rect2(Vector2(atlas_coords * TILE_SIZE), Vector2(TILE_SIZE, TILE_SIZE))
  get_tree().create_timer(max_lifetime).timeout.connect(_on_timeout)
  lock_rotation = true

func _on_timeout() -> void:
  if linear_velocity.length() <= settle_speed:
    _settle()
  else:
   queue_free()   
  
func _settle() -> void:
  if settled:
    return
    
  settled = true
  terrain.fill_cell_at(global_position, atlas_coords)
  queue_free()

func _physics_process(_delta):
  if ground_check.is_colliding():
    _settle()
