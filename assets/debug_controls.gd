class_name DebugControls extends Node2D

@export var enemy_controller: EnemyController
@export var game_manager: GameManager

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
        
  if Input.is_action_just_pressed("debug_spawn_basic_enemy"):
    enemy_controller.spawn_basic_enemy()
  
  if Input.is_action_just_pressed("debug_spawn_flying_enemy"):
    enemy_controller.spawn_dark_flying_enemy()
  
  if Input.is_action_just_pressed("debug_spawn_flying_2"):
    enemy_controller.spawn_light_flying_enemy()
  
  if Input.is_action_just_pressed("debug_spawn_big_enemy"):
    enemy_controller.spawn_big_enemy()
  
  if Input.is_action_just_pressed("debug_floating_text"):
    var floater = FloatingTextComponent.create()
    add_child(floater)
    floater.play(str("+", randi_range(1,5)), get_global_mouse_position())
    
  if Input.is_action_just_pressed("debug_spawn_debris"):
    game_manager.spawn_debris(get_global_mouse_position(), randi_range(1,5), Debris.TerrainType.DIRT)
