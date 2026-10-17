class_name EnemyStats extends Resource

enum SpawnPoint { WALKER, FLYER }

@export var name: String
@export var speed: float = 400.0
@export var max_health: float = 10.0
@export var point_value: int = 1
@export var sprite_frames: SpriteFrames

@export_group("Movement")
@export var has_gravity: bool = true
@export var jump_strength: float = 0.0 # 0 = no jump component

@export_group("Spawn Settings", "spawn_")
@export var spawn_point: SpawnPoint = SpawnPoint.WALKER
@export var unlocks_at_wave: int = 1
@export_range(0, 50, 1) var spawn_x_variance: float = 0.0
@export_range(0, 50, 1) var spawn_y_variance: float = 0.0
