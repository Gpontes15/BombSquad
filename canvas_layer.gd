extends CanvasLayer

func _on_restart_pressed():
	GameController.goto_scene("res://scenes/screens/startscreen.tscn")


func _on_quit_pressed():
	get_tree().quit()
