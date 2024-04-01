extends CanvasLayer

signal loading_screen_has_full_coverage

@onready var anim_player: AnimationPlayer = $AnimationPlayer
@onready var progress_bar = $ProgressBar

func update_progress_bar(new_val: float) -> void:
	progress_bar.set_value_no_signal(new_val * 100)

func start_outro_animation() -> void:
	anim_player.play("end_load")
	await Signal(anim_player, "animation_finished")
	queue_free()

func start_icon_spin():
	anim_player.play("load")
