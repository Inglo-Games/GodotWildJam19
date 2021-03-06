extends Control

onready var OptionsMenu = preload("res://scenes/options.tscn")
onready var CreditsMenu = preload("res://scenes/credits.tscn")

func _ready():
	$panel/container/start_btn.grab_focus()
	
	# Don't show the quit button if in-browser
	if(OS.get_name() == "HTML5"):
		$panel/container/quit_btn.visible = false

func _on_start_btn_pressed():
	get_tree().change_scene("res://scenes/intro.tscn")

func _on_options_btn_button_up():
	var opts = OptionsMenu.instance()
	add_child(opts)
	opts.popup_centered()

func _on_credits_btn_button_up():
	var credits = CreditsMenu.instance()
	add_child(credits)
	credits.popup_centered()

func _on_quit_btn_button_up():
	get_tree().quit()
