extends Control

const DIALOGUE_LINES := {
	"intro_01": "Welcome aboard Captain!  All crew is accounted for and we are ready to raise the sails on your orders.",
	"intro_02": "The boys just finished cleaning the cannons Captain.  How about ye fire one, see how they are?",
	"tut_01": "Raise sails: Up\nLower sails: Down\nTurn port: Left\nTurn starboard: Right",
	"tut_02": "Fire port side cannon: A\nFire starboard side cannon: D",
	"out_of_bounds": "Captain, turn around!",
	"clue_01": "Our scouts found a clue on this island: \"Sail east, over the C, if you find the F you've gone too far\"",
	"clue_02": "A clue: \"The gang of three keeps watch above the keep\"",
	"clue_03": "",
	"island_01": "A fine island you've discovered, but alas it be not the one for which we search.",
	"island_02": "How many more clues could there be?",
	"island_03": "I just might build a shack on this island, after we find that treasure!",
	"island_04": "",
	"island_05": "That looks like the right island!  We're so close Captain!",
	"final_battle": "They may have gotten here first, but the only thing they'll discover is their grave!",
	"final_victory": "Congratulations Captain!  That treasure is ours!"
}

onready var subs = $subtitles
onready var voice = $voiceover

func _on_health_changed(amount:int):
	$health_back/VBoxContainer/health_label.text = "HEALTH: %d" % amount

func _on_coords_changed(coords:Vector2):
	var lat = 13.16 - (coords.y / 20000.0)
	var lon = 72.48 - (coords.x / 20000.0)
	$health_back/VBoxContainer/coords_label.text = "%.2f N  %.2f W" % [lat, lon]

func _on_play_line(line:String):
	
	if(ProjectSettings.get_setting("Accessibility/subtitles")):
		if DIALOGUE_LINES.has(line):
			subs.text = DIALOGUE_LINES[line]
			subs.visible = true
	
	var audio_file_name := "res://assets/audio/voices/%s.wav" % line
	if(ResourceLoader.exists(audio_file_name)):
		voice.stream = load(audio_file_name)
		
		# Even if voices are off, we still play the file to keep the timing of the
		# subtitles
		if(ProjectSettings.get_setting("Accessibility/voices")):
			voice.volume_db = 0.0
		else:
			voice.volume_db = -64.0
		voice.play()
		
		# Cleanup after done
		yield(voice, "finished")
		subs.visible = false
	
	# If the audio file doesn't exist...
	else:
		yield(get_tree().create_timer(5.0), "timeout")
		subs.visible = false
	
		# Display tutorial lines after the intro lines
		if(line == "intro_01"):
			subs.text = DIALOGUE_LINES["tut_01"]
			subs.visible = true
			yield(get_tree().create_timer(8.0), "timeout")
			subs.visible = false
		elif(line == "intro_02"):
			subs.text = DIALOGUE_LINES["tut_02"]
			subs.visible = true
			yield(get_tree().create_timer(8.0), "timeout")
			subs.visible = false
		elif(line == "final_victory"):
			_on_game_won()

func _on_game_over():
	$game_over_panel.popup_centered()

func _on_game_won():
	$victory_panel.popup_centered()

func _on_menu_btn_button_up():
	get_tree().paused = false
	queue_free()
	get_tree().change_scene("res://scenes/main_menu.tscn")
