extends Node

const TRACK_INTRO = preload("res://assets/audio/music/intro.wav")
const TRACK_MAIN = preload("res://assets/audio/music/main.wav")
const TRACK_GAME_OVER = preload("res://assets/audio/music/game_over.wav")

var BG_MUSIC_NODE: AudioStreamPlayer = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  BG_MUSIC_NODE = AudioStreamPlayer.new()
  BG_MUSIC_NODE.stream = TRACK_INTRO
  BG_MUSIC_NODE.autoplay = true
  BG_MUSIC_NODE.bus = "Music"
  add_child(BG_MUSIC_NODE)

  # Just to not destroy peoples eardrums
  AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(0.2))

  Events.go_to_menu.connect(func(): switch_track(TRACK_INTRO))
  Events.go_to_options.connect(func(): switch_track(TRACK_INTRO))
  Events.go_to_game.connect(func(): switch_track(TRACK_MAIN))
  Events.go_to_game_over.connect(func(): switch_track(TRACK_GAME_OVER))
  Events.toggle_pause_mode.connect(func(paused: bool):
    switch_track(TRACK_INTRO if paused else TRACK_MAIN)
  )

func switch_track(new_track: AudioStream) -> void:
  if BG_MUSIC_NODE.stream == new_track:
    return

  var position: float = BG_MUSIC_NODE.get_playback_position()
  BG_MUSIC_NODE.stream = new_track
  BG_MUSIC_NODE.play(position)
