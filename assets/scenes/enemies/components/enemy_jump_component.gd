class_name EnemyJumpComponent extends EnemyComponent

var raycast: RayCast2D
var jump_strength: float
var jump_delay: float # Not used yet

func _init(_jump_strength: float = 100.0, _jump_delay: float = 0.0) -> void:
  jump_strength = _jump_strength
  jump_delay = _jump_delay

func _connect_signals() -> void:
  enemy.before_move.connect(jump_check)

func _ready():
  raycast = RayCast2D.new()
  enemy.add_child.call_deferred(raycast)
  var sprite_size = enemy.stats.sprite_frames.get_frame_texture("default",0).get_size()
  raycast.position.y = -2 + sprite_size.y / 2
  raycast.target_position = Vector2(-1 - sprite_size.x/2,0)
  raycast.collision_mask = 4

func jump_check(_delta:float):
  if enemy.is_on_floor() && raycast.is_colliding():
    enemy.velocity.y = -jump_strength
