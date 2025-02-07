extends Control

# android screen flicker
func _process(_delta):
	if Global.OS_name != "Android":
		set_process(false)
		set_physics_process(false)
		return
	for i in get_children():
		i.update()

func _on_OK_pressed():
	get_tree().change_scene_to_file("res://Main/Main.tscn")

func _on_license_pressed():
	OS.shell_open("https://creativecommons.org/licenses/by/4.0")

func _on_game_pressed():
	OS.shell_open($game.tooltip_text)

func _on_blogger_pressed() -> void:
	OS.shell_open($social_media/hb0/blogger.tooltip_text)

func _on_blue_sky_pressed() -> void:
	OS.shell_open($social_media/hb0/blue_sky.tooltip_text)

func _on_chess_com_pressed() -> void:
	OS.shell_open($social_media/hb0/chess_com.tooltip_text)

func _on_clouthub_pressed() -> void:
	OS.shell_open($social_media/hb0/clouthub.tooltip_text)

func _on_diamond_pressed() -> void:
	OS.shell_open($social_media/hb0/diamond.tooltip_text)

func _on_diaspora_pressed() -> void:
	OS.shell_open($social_media/hb0/diaspora.tooltip_text)

func _on_discord_pressed() -> void:
	OS.shell_open($social_media/hb0/discord.tooltip_text)

func _on_facebook_pressed() -> void:
	OS.shell_open($social_media/hb0/facebook.tooltip_text)

func _on_flickr_pressed() -> void:
	OS.shell_open($social_media/hb0/flickr.tooltip_text)

func _on_flipboard_pressed() -> void:
	OS.shell_open($social_media/hb0/flipboard.tooltip_text)

func _on_gab_pressed() -> void:
	OS.shell_open($social_media/hb1/gab.tooltip_text)

func _on_gettr_pressed() -> void:
	OS.shell_open($social_media/hb1/gettr.tooltip_text)

func _on_instagram_pressed() -> void:
	OS.shell_open($social_media/hb1/instagram.tooltip_text)

func _on_itch_io_pressed() -> void:
	OS.shell_open($social_media/hb1/itch_io.tooltip_text)

func _on_justpaste_it_pressed() -> void:
	OS.shell_open($social_media/hb1/justpaste_it.tooltip_text)

func _on_lichess_pressed() -> void:
	OS.shell_open($social_media/hb1/lichess.tooltip_text)

func _on_linkedin_pressed() -> void:
	OS.shell_open($social_media/hb1/linkedin.tooltip_text)

func _on_livejournal_pressed() -> void:
	OS.shell_open($social_media/hb1/livejournal.tooltip_text)

func _on_mastodon_pressed() -> void:
	OS.shell_open($social_media/hb1/mastodon.tooltip_text)

func _on_matrix_pressed() -> void:
	OS.shell_open($social_media/hb1/matrix.tooltip_text)

func _on_medium_pressed() -> void:
	OS.shell_open($social_media/hb2/medium.tooltip_text)

func _on_mewe_pressed() -> void:
	OS.shell_open($social_media/hb2/mewe.tooltip_text)

func _on_minds_pressed() -> void:
	OS.shell_open($social_media/hb2/minds.tooltip_text)

func _on_odysee_pressed() -> void:
	OS.shell_open($social_media/hb2/odysee.tooltip_text)

func _on_pinterest_pressed() -> void:
	OS.shell_open($social_media/hb2/pinterest.tooltip_text)

func _on_primal_pressed() -> void:
	OS.shell_open($social_media/hb2/primal.tooltip_text)

func _on_reddit_pressed() -> void:
	OS.shell_open($social_media/hb2/reddit.tooltip_text)

func _on_rumble_pressed() -> void:
	OS.shell_open($social_media/hb2/rumble.tooltip_text)

func _on_spoutible_pressed() -> void:
	OS.shell_open($social_media/hb2/spoutible.tooltip_text)

func _on_steemit_pressed() -> void:
	OS.shell_open($social_media/hb2/steemit.tooltip_text)

func _on_telegram_pressed() -> void:
	OS.shell_open($social_media/hb3/telegram.tooltip_text)

func _on_the_dots_pressed() -> void:
	OS.shell_open($social_media/hb3/the_dots.tooltip_text)

func _on_threads_pressed() -> void:
	OS.shell_open($social_media/hb3/threads.tooltip_text)

func _on_tiktok_pressed() -> void:
	OS.shell_open($social_media/hb3/tiktok.tooltip_text)


func _on_tumblr_pressed() -> void:
	OS.shell_open($social_media/hb3/tumblr.tooltip_text)

func _on_vk_pressed() -> void:
	OS.shell_open($social_media/hb3/vk.tooltip_text)

func _on_wordpress_pressed() -> void:
	OS.shell_open($social_media/hb3/wordpress.tooltip_text)

func _on_x_pressed() -> void:
	OS.shell_open($social_media/hb3/x.tooltip_text)

func _on_xing_pressed() -> void:
	OS.shell_open($social_media/hb3/xing.tooltip_text)

func _on_youtube_pressed() -> void:
	OS.shell_open($social_media/hb3/youtube.tooltip_text)
