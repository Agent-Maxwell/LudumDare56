extends CanvasLayer

signal change_sensitivity(sensValue)

#Variables needed the change bus volumes
@onready var masterBus := AudioServer.get_bus_index("Master")
@onready var musicBus := AudioServer.get_bus_index("Music")
@onready var sfxBus := AudioServer.get_bus_index("Sfx")
@onready var masterSlider = $"MarginContainer/Background Color/Button Spacer/Master Volume/Master Slider"
@onready var musicSlider = $"MarginContainer/Background Color/Button Spacer/Music Volume/Music Slider"
@onready var sfxSlider = $"MarginContainer/Background Color/Button Spacer/SFX Volume/SFX Slider"

@onready var sensitivitySlider = $"MarginContainer/Background Color/Button Spacer/Sensitivity/Sensitivity Slider"

#Syncs volumes up to the values in the buses at start of game
func _ready() -> void:
	masterSlider.value = db_to_linear(AudioServer.get_bus_volume_db(masterBus))
	musicSlider.value = db_to_linear(AudioServer.get_bus_volume_db(musicBus))
	sfxSlider.value = db_to_linear(AudioServer.get_bus_volume_db(sfxBus))

signal apply_options

func _on_apply_pressed() -> void:
	emit_signal("apply_options")

#Sets a slider's corresponding bus to that value
func _on_master_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(masterBus, linear_to_db(masterSlider.value))
	
func _on_music_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(musicBus, linear_to_db(musicSlider.value))

func _on_sfx_slider_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(sfxBus, linear_to_db(sfxSlider.value))

#Emits the sensitivity to player when the sensitivity slider value is altered
func _on_sensitivity_slider_value_changed(value: float) -> void:
	emit_signal("change_sensitivity", sensitivitySlider.value)
