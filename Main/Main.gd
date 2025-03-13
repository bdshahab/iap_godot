extends Control

const normal_color = Color(0.5, 0.5, 0.5, 1)
const hover_color = Color(0.7, 0.7, 0.7, 1)

func _ready():
	Global.OS_name = OS.get_name()
	OS.low_processor_usage_mode = OS.get_name() != "Android"
	get_window().mode = Window.MODE_MAXIMIZED if (true) else Window.MODE_WINDOWED
	# This is for MAC OS and HTML not other OSs!
#	DisplayServer.set_native_icon("res://Icon.png")
	test()

func _on_Pay_Button_pressed():
	get_tree().change_scene_to_file("res://Payment/select_coin.tscn")

func _on_About_Button_pressed():
	get_tree().change_scene_to_file("res://About/about.tscn")

func _on_Exit_Button_pressed():
	get_tree().quit()

func _on_Main_visibility_changed():
	if Global.user_bought:
		$Purchase_situation/text_bought_situation.text = "You bought this app!"
		$Purchase_situation.self_modulate = "008000"
	else:
		$Purchase_situation/text_bought_situation.text = "You have not purchased this app yet!"
		$Purchase_situation.self_modulate = "800000"

func _on_pay_button_mouse_entered():
	$color_Pay_Button.color = hover_color

func _on_pay_button_mouse_exited():
	$color_Pay_Button.color = normal_color

func _on_about_button_mouse_entered():
	$color_About_Button.color = hover_color

func _on_about_button_mouse_exited():
	$color_About_Button.color = normal_color

func _on_exit_button_mouse_entered():
	$color_Exit_Button.color = hover_color

func _on_exit_button_mouse_exited():
	$color_Exit_Button.color = normal_color
