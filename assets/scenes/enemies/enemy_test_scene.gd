extends Node2D

func _check_under_cursor():
  global_position = get_global_mouse_position()
  

func _process(_delta):
  if Input.is_action_just_pressed("debug_click"):
    var worldState = get_world_2d().direct_space_state
    var query = PhysicsPointQueryParameters2D.new()
    query.collision_mask = 2
    query.collide_with_areas = true
    query.position = get_global_mouse_position()
    for collision in worldState.intersect_point(query):
      if collision.collider is EnemyHurtbox:
        (collision.collider as EnemyHurtbox).take_damage(5)
