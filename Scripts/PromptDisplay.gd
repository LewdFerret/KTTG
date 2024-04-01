extends Panel

@export_category("Prompt Display")
@export var prompt: String = ""
@export var texture: Texture2D
@export var day: int = 1
@onready var day_lbl = $Day
@export var scene_to_open: PackedScene

@export_subgroup("Content Warning")
@export var hasCW: bool = true
@export_color_no_alpha var color: Color
@export_enum("Light", "Medium", "Hard") var cw_name = "Light"
@export_multiline var eod: String = ""

@onready var promptLbl: Label = $Prompt
@onready var texture_rect: TextureRect = $TextureRect

@onready var cw_color = $CW_Color
@onready var cw_lbl = $CW_Lbl
@onready var cw_eod = $CW_EOD

func _ready():
	promptLbl.text = prompt
	texture_rect.texture = texture
	day_lbl.text = day_lbl.text % day
	
	if hasCW:
		cw_color.color = color
		cw_lbl.text = "%s Content Warning" % cw_name
		cw_eod.text = eod
	else:
		cw_color.color = Color8(0,0,0,0);
		cw_lbl.text = ""
		cw_eod.text = ""

func _on_mouse_entered():
	$MouseOverlay.visible = true

func _on_mouse_exited():
	$MouseOverlay.visible = false

func _on_gui_input(event):
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
<<<<<<< HEAD
		increase_views(day)
		showLoadingScreen()

func showLoadingScreen():
	if scene_to_open:
		Load.load_scene(scene_to_open.resource_path, true)

func increase_views(d: int) -> void:
	var f = FileAccess.open("user://views.dat", FileAccess.READ_WRITE)
	var data = []
	if f:
		while !f.eof_reached():
			data.append(int(f.get_line()))
		if data != [] or data != null:
			data[d - 1] += 1
			f.store_string("")
			f.seek(0)
			for i in range(0, 31):
				f.store_line(str(data[i]))
			
		f.close()
	else:
		printerr("Error loading file \"user://views.dat\"!")
=======
		showLoadingScreen()

func showLoadingScreen():
	pass
>>>>>>> 5f3cdfd (Initial Commit)

func _on_focus_entered():
	$FocusOverlay.visible = true

func _on_focus_exited():
	$FocusOverlay.visible = false
