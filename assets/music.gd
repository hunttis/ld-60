extends Node

var BG_MUSIC_NODE: AudioStreamPlayer = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
  BG_MUSIC_NODE = AudioStreamPlayer.new()
  BG_MUSIC_NODE.stream = load("res://assets/audio/music/intro.wav")
  BG_MUSIC_NODE.autoplay = true
  BG_MUSIC_NODE.bus = "Music"
  add_child(BG_MUSIC_NODE)

  # Just to not destroy peoples eardrums
  AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(0.2))
