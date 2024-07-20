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

func _on_lnk_bio_pressed():
	OS.shell_open($lnk_bio.tooltip_text)

func _on_blogger_pressed():
	OS.shell_open($social_media/hb0/blogger.tooltip_text)

func _on_chess_com_pressed():
	OS.shell_open($social_media/hb0/chess_com.tooltip_text)

func _on_clouthub_pressed():
	OS.shell_open($social_media/hb0/clouthub.tooltip_text)

func _on_diaspora_pressed():
	OS.shell_open($social_media/hb0/diaspora.tooltip_text)

func _on_discord_pressed():
	OS.shell_open($social_media/hb1/discord.tooltip_text)

func _on_facebook_pressed():
	OS.shell_open($social_media/hb1/facebook.tooltip_text)

func _on_flickr_pressed():
	OS.shell_open($social_media/hb1/flickr.tooltip_text)

func _on_flipboard_pressed():
	OS.shell_open($social_media/hb1/flipboard.tooltip_text)

func _on_gab_pressed():
	OS.shell_open($social_media/hb1/gab.tooltip_text)

func _on_gettr_pressed():
	OS.shell_open($social_media/hb1/gettr.tooltip_text)

func _on_instagram_pressed():
	OS.shell_open($social_media/hb1/instagram.tooltip_text)

func _on_itch_io_pressed():
	OS.shell_open($social_media/hb1/itch_io.tooltip_text)

func _on_justpaste_it_pressed():
	OS.shell_open($social_media/hb1/justpaste_it.tooltip_text)

func _on_lichess_pressed():
	OS.shell_open($social_media/hb1/lichess.tooltip_text)

func _on_linkedin_pressed():
	OS.shell_open($social_media/hb2/linkedin.tooltip_text)

func _on_livejournal_pressed():
	OS.shell_open($social_media/hb2/livejournal.tooltip_text)

func _on_mastodon_pressed():
	OS.shell_open($social_media/hb2/mastodon.tooltip_text)

func _on_matrix_pressed():
	OS.shell_open($social_media/hb2/matrix.tooltip_text)

func _on_medium_pressed():
	OS.shell_open($social_media/hb2/medium.tooltip_text)

func _on_mewe_pressed():
	OS.shell_open($social_media/hb2/mewe.tooltip_text)

func _on_minds_pressed():
	OS.shell_open($social_media/hb2/minds.tooltip_text)

func _on_odysee_pressed():
	OS.shell_open($social_media/hb2/odysee.tooltip_text)

func _on_pinterest_pressed():
	OS.shell_open($social_media/hb2/pinterest.tooltip_text)

func _on_reddit_pressed():
	OS.shell_open($social_media/hb2/reddit.tooltip_text)

func _on_steemit_pressed():
	OS.shell_open($social_media/hb3/steemit.tooltip_text)

func _on_telegram_pressed():
	OS.shell_open($social_media/hb3/telegram.tooltip_text)

func _on_the_dots_pressed():
	OS.shell_open($social_media/hb3/the_dots.tooltip_text)

func _on_tiktok_pressed():
	OS.shell_open($social_media/hb3/tiktok.tooltip_text)

func _on_tumblr_pressed():
	OS.shell_open($social_media/hb3/tumblr.tooltip_text)

func _on_vk_pressed():
	OS.shell_open($social_media/hb3/vk.tooltip_text)

func _on_wordpress_pressed():
	OS.shell_open($social_media/hb3/wordpress.tooltip_text)

func _on_x_pressed():
	OS.shell_open($social_media/hb3/x.tooltip_text)

func _on_xing_pressed():
	OS.shell_open($social_media/hb3/xing.tooltip_text)

func _on_youtube_pressed():
	OS.shell_open($social_media/hb3/youtube.tooltip_text)
