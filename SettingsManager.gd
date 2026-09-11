extends Node

const SETTINGS_PATH := "user://settings.cfg"


# ============================================================
# DISPLAY
# ============================================================

var Fullscreen: bool = true
var Windowmode: String = "Fullscreen"
var VSync: bool = true


# ============================================================
# AUDIO
# ============================================================

var MasterVolume: float = 100.0
var MusicVolume: float = 100.0
var SFXVolume: float = 100.0
var NarratorVolume: float = 100.0


# ============================================================
# GAMEPLAY
# ============================================================

var MouseSensitivity: float = 0.8
var TextSpeed: float = 0.6
var ShowTutorials: bool = true


# ============================================================
# ACCESSIBILITY
# ============================================================

var Screenshake: bool = true
var FlashingEffects: bool = true
var Subtitles: bool = true


# ============================================================
# START
# ============================================================

func _ready() -> void:
	print("================================")
	print("SETTINGS MANAGER READY")
	print("Path: ", ProjectSettings.globalize_path(SETTINGS_PATH))
	print("Exists: ", FileAccess.file_exists(SETTINGS_PATH))
	print("================================")

	load_settings()
	apply_settings()


# ============================================================
# APPLY ALL SETTINGS
# ============================================================

func apply_settings() -> void:
	apply_display_settings()
	apply_audio_settings()


# ============================================================
# DISPLAY SETTINGS
# ============================================================

func apply_display_settings() -> void:

	# Window Mode
	match Windowmode:

		"Fullscreen":
			Fullscreen = true

			DisplayServer.window_set_mode(
				DisplayServer.WINDOW_MODE_FULLSCREEN
			)

		"Windowed":
			Fullscreen = false

			DisplayServer.window_set_mode(
				DisplayServer.WINDOW_MODE_WINDOWED
			)

			# Fenster auf Bildschirmgröße setzen
			var screen_size := DisplayServer.screen_get_size()

			DisplayServer.window_set_size(screen_size)
			DisplayServer.window_set_position(Vector2i.ZERO)

		_:
			# Ungültiger Wert -> Standard
			Windowmode = "Fullscreen"
			Fullscreen = true

			DisplayServer.window_set_mode(
				DisplayServer.WINDOW_MODE_FULLSCREEN
			)


	# VSync
	if VSync:
		DisplayServer.window_set_vsync_mode(
			DisplayServer.VSYNC_ENABLED
		)
	else:
		DisplayServer.window_set_vsync_mode(
			DisplayServer.VSYNC_DISABLED
		)


# ============================================================
# AUDIO SETTINGS
# ============================================================

func apply_audio_settings() -> void:

	set_audio_bus_volume("Master", MasterVolume)
	set_audio_bus_volume("Music", MusicVolume)
	set_audio_bus_volume("SFX", SFXVolume)
	set_audio_bus_volume("Narrator", NarratorVolume)


func set_audio_bus_volume(
	bus_name: String,
	volume: float
) -> void:

	var bus_index := AudioServer.get_bus_index(bus_name)

	if bus_index == -1:
		push_warning(
			"Audio Bus nicht gefunden: " + bus_name
		)
		return

	volume = clampf(volume, 0.0, 100.0)

	if volume <= 0.0:
		AudioServer.set_bus_mute(bus_index, true)
	else:
		AudioServer.set_bus_mute(bus_index, false)

		AudioServer.set_bus_volume_db(
			bus_index,
			linear_to_db(volume / 100.0)
		)


# ============================================================
# SAVE SETTINGS
# ============================================================

func save_settings() -> void:
	var config := ConfigFile.new()

	# DISPLAY
	config.set_value("Display", "Fullscreen", Fullscreen)
	config.set_value("Display", "Windowmode", Windowmode)
	config.set_value("Display", "VSync", VSync)

	# AUDIO
	config.set_value("Audio", "MasterVolume", MasterVolume)
	config.set_value("Audio", "MusicVolume", MusicVolume)
	config.set_value("Audio", "SFXVolume", SFXVolume)
	config.set_value("Audio", "NarratorVolume", NarratorVolume)

	# GAMEPLAY
	config.set_value("Gameplay", "MouseSensitivity", MouseSensitivity)
	config.set_value("Gameplay", "TextSpeed", TextSpeed)
	config.set_value("Gameplay", "ShowTutorials", ShowTutorials)

	# ACCESSIBILITY
	config.set_value("Accessibility", "Screenshake", Screenshake)
	config.set_value("Accessibility", "FlashingEffects", FlashingEffects)
	config.set_value("Accessibility", "Subtitles", Subtitles)

	var error := config.save(SETTINGS_PATH)

	print("================================")
	print("SETTINGS SAVE")
	print("Path: ", ProjectSettings.globalize_path(SETTINGS_PATH))
	print("Error: ", error)
	print("MasterVolume: ", MasterVolume)
	print("MusicVolume: ", MusicVolume)
	print("SFXVolume: ", SFXVolume)
	print("Windowmode: ", Windowmode)
	print("================================")

	if error != OK:
		push_error("SETTINGS SAVE FAILED: " + str(error))


# ============================================================
# LOAD SETTINGS
# ============================================================

func load_settings() -> void:
	var config := ConfigFile.new()

	var full_path := ProjectSettings.globalize_path(SETTINGS_PATH)

	print("================================")
	print("SETTINGS LOAD")
	print("Path: ", full_path)
	print("File exists: ", FileAccess.file_exists(SETTINGS_PATH))

	var error := config.load(SETTINGS_PATH)

	print("Load error: ", error)
	print("Load error name: ", error_string(error))

	if error != OK:
		push_error(
			"Settings konnten nicht geladen werden: "
			+ error_string(error)
		)
		return

	print("Settings file loaded successfully!")

	# ========================================================
	# RAW VALUES
	# ========================================================

	print("RAW VALUES FROM FILE:")
	print(
		"MasterVolume: ",
		config.get_value("Audio", "MasterVolume", -1.0)
	)

	print(
		"MusicVolume: ",
		config.get_value("Audio", "MusicVolume", -1.0)
	)

	print(
		"SFXVolume: ",
		config.get_value("Audio", "SFXVolume", -1.0)
	)

	print(
		"NarratorVolume: ",
		config.get_value("Audio", "NarratorVolume", -1.0)
	)

	print(
		"Windowmode: ",
		config.get_value("Display", "Windowmode", "UNKNOWN")
	)

	print(
		"VSync: ",
		config.get_value("Display", "VSync", "UNKNOWN")
	)

	# ========================================================
	# DISPLAY
	# ========================================================

	Windowmode = str(
		config.get_value(
			"Display",
			"Windowmode",
			"Fullscreen"
		)
	)

	VSync = bool(
		config.get_value(
			"Display",
			"VSync",
			true
		)
	)

	if Windowmode != "Fullscreen" and Windowmode != "Windowed":
		Windowmode = "Fullscreen"

	Fullscreen = Windowmode == "Fullscreen"


	# ========================================================
	# AUDIO
	# ========================================================

	MasterVolume = float(
		config.get_value(
			"Audio",
			"MasterVolume",
			100.0
		)
	)

	MusicVolume = float(
		config.get_value(
			"Audio",
			"MusicVolume",
			100.0
		)
	)

	SFXVolume = float(
		config.get_value(
			"Audio",
			"SFXVolume",
			100.0
		)
	)

	NarratorVolume = float(
		config.get_value(
			"Audio",
			"NarratorVolume",
			100.0
		)
	)


	# ========================================================
	# GAMEPLAY
	# ========================================================

	MouseSensitivity = float(
		config.get_value(
			"Gameplay",
			"MouseSensitivity",
			0.8
		)
	)

	TextSpeed = float(
		config.get_value(
			"Gameplay",
			"TextSpeed",
			0.6
		)
	)

	ShowTutorials = bool(
		config.get_value(
			"Gameplay",
			"ShowTutorials",
			true
		)
	)


	# ========================================================
	# ACCESSIBILITY
	# ========================================================

	Screenshake = bool(
		config.get_value(
			"Accessibility",
			"Screenshake",
			true
		)
	)

	FlashingEffects = bool(
		config.get_value(
			"Accessibility",
			"FlashingEffects",
			true
		)
	)

	Subtitles = bool(
		config.get_value(
			"Accessibility",
			"Subtitles",
			true
		)
	)


	# ========================================================
	# DEBUG - FINAL VALUES
	# ========================================================

	print("FINAL SETTINGS AFTER LOAD:")
	print("MasterVolume: ", MasterVolume)
	print("MusicVolume: ", MusicVolume)
	print("SFXVolume: ", SFXVolume)
	print("NarratorVolume: ", NarratorVolume)
	print("Windowmode: ", Windowmode)
	print("VSync: ", VSync)
	print("================================")


# ============================================================
# RESET SETTINGS
# ============================================================

func reset_settings() -> void:

	# --------------------------------------------------------
	# DISPLAY
	# --------------------------------------------------------

	Fullscreen = true
	Windowmode = "Fullscreen"
	VSync = true


	# --------------------------------------------------------
	# AUDIO
	# --------------------------------------------------------

	MasterVolume = 100.0
	MusicVolume = 100.0
	SFXVolume = 100.0
	NarratorVolume = 100.0


	# --------------------------------------------------------
	# GAMEPLAY
	# --------------------------------------------------------

	MouseSensitivity = 0.8
	TextSpeed = 0.6
	ShowTutorials = true


	# --------------------------------------------------------
	# ACCESSIBILITY
	# --------------------------------------------------------

	Screenshake = true
	FlashingEffects = true
	Subtitles = true


	# --------------------------------------------------------
	# APPLY
	# --------------------------------------------------------

	apply_settings()

	# --------------------------------------------------------
	# SAVE
	# --------------------------------------------------------

	save_settings()


# ============================================================
# GET ALL SETTINGS
# ============================================================

func give_all_settings() -> Dictionary:

	return {
		"Fullscreen": Fullscreen,
		"Windowmode": Windowmode,
		"VSync": VSync,

		"MasterVolume": MasterVolume,
		"MusicVolume": MusicVolume,
		"SFXVolume": SFXVolume,
		"NarratorVolume": NarratorVolume,

		"MouseSensitivity": MouseSensitivity,
		"TextSpeed": TextSpeed,
		"ShowTutorials": ShowTutorials,

		"Screenshake": Screenshake,
		"FlashingEffects": FlashingEffects,
		"Subtitles": Subtitles
	}


# ============================================================
# DEBUG
# ============================================================

func print_settings_path() -> void:
	print(
		"Settings befinden sich hier:"
	)
	print(
		ProjectSettings.globalize_path(SETTINGS_PATH)
	)


func print_current_settings() -> void:
	print("========== CURRENT SETTINGS ==========")
	print(give_all_settings())
	print("======================================")
