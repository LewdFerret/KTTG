extends Node

signal progress_changed(progress)
signal load_done

var _load_scene_path: String = "res://Scenes/Load.tscn"
var _load_screen = load(_load_scene_path)
var _loaded_resource: PackedScene
var _scene_path: String
var _progress: Array = []

var _use_sub_threads: bool

func _ready():
	set_process(false)

func load_scene(scene_path: String, use_sub_threads: bool = false) -> void:
	_scene_path = scene_path
	_use_sub_threads = use_sub_threads
	
	var new_loading_screen = _load_screen.instantiate()
	get_tree().root.add_child(new_loading_screen)
	
	self.progress_changed.connect(new_loading_screen.update_progress_bar)
	self.load_done.connect(new_loading_screen.start_outro_animation)
	
	await Signal(new_loading_screen, "loading_screen_has_full_coverage")
	
	start_load()

func start_load() -> void:
	var state = ResourceLoader.load_threaded_request(_scene_path, "", _use_sub_threads)
	if state == OK:
		set_process(true)

func _process(_delta):
	var load_status = ResourceLoader.load_threaded_get_status(_scene_path, _progress)
	match load_status:
		0, 2: #? THREAD_LOAD_INVALID_RESOURCE, THREAD_LOAD_FAILED
			set_process(false)
			return
		1: #? THREAD_LOAD_IN_PROGRESS
			progress_changed.emit(_progress[0])
		3: #? THREAD_LOAD_LOADED
			_loaded_resource = ResourceLoader.load_threaded_get(_scene_path)
			progress_changed.emit(1.0)
			load_done.emit()
			get_tree().change_scene_to_packed(_loaded_resource)
