extends Control

const normal_color = Color(1, 1, 1, 1)
const hover_color = Color(0.7, 0.7, 0.7, 1)

func  _ready():
	$selected_coin.text = ""

func _on_back_pressed():
	get_tree().change_scene_to_file("res://Main/Main.tscn")

func _on_next_pressed():
	if $selected_coin.text == "":
		$AnimationPlayer.play("selected_coin")
	else:
		Global.selected_payment = $selected_coin.text
		get_tree().change_scene_to_file("res://Payment/Payment.tscn")

func _on_bitcoin_pressed():
	$selected_coin.text = "Bitcoin (BTC)"
	$AnimationPlayer.play("normal")

func _on_bitcoin_cash_pressed():
	$selected_coin.text = "Bitcoin Cash (BCH)"
	$AnimationPlayer.play("normal")

func _on_bitcoin_gold_pressed():
	$selected_coin.text = "Bitcoin Gold (BTG)"
	$AnimationPlayer.play("normal")

func _on_dash_pressed():
	$selected_coin.text = "Dash (DASH)"
	$AnimationPlayer.play("normal")

func _on_digibyte_pressed():
	$selected_coin.text = "DigiByte (DGB)"
	$AnimationPlayer.play("normal")

func _on_dogecoin_pressed():
	$selected_coin.text = "Dogecoin (DOGE)"
	$AnimationPlayer.play("normal")

func _on_ethereum_pressed():
	$selected_coin.text = "Ethereum (ETH)"
	$AnimationPlayer.play("normal")

func _on_firo_pressed():
	$selected_coin.text = "FIRO (FIRO)"
	$AnimationPlayer.play("normal")

func _on_komodo_pressed():
	$selected_coin.text = "Komodo (KMD)"
	$AnimationPlayer.play("normal")

func _on_litecoin_pressed():
	$selected_coin.text = "Litecoin (LTC)"
	$AnimationPlayer.play("normal")

func _on_qtum_pressed():
	$selected_coin.text = "Qtum (QTUM)"
	$AnimationPlayer.play("normal")

func _on_ravencoin_pressed():
	$selected_coin.text = "Ravencoin (RVN)"
	$AnimationPlayer.play("normal")

func _on_reddcoin_pressed():
	$selected_coin.text = "ReddCoin (RDD)"
	$AnimationPlayer.play("normal")

func _on_verge_pressed():
	$selected_coin.text = "Verge (XVG)"
	$AnimationPlayer.play("normal")

func _on_vertcoin_pressed():
	$selected_coin.text = "Vertcoin (VTC)"
	$AnimationPlayer.play("normal")

func _on_zcash_pressed():
	$selected_coin.text = "Zcash (ZEC)"
	$AnimationPlayer.play("normal")

func _on_bitcoin_mouse_entered():
	$coins/bitcoin.self_modulate = hover_color

func _on_bitcoin_mouse_exited():
	$coins/bitcoin.self_modulate = normal_color

func _on_bitcoin_cash_mouse_entered():
	$coins/bitcoin_cash.self_modulate = hover_color

func _on_bitcoin_cash_mouse_exited():
	$coins/bitcoin_cash.self_modulate = normal_color

func _on_bitcoin_gold_mouse_entered():
	$coins/bitcoin_gold.self_modulate = hover_color

func _on_bitcoin_gold_mouse_exited():
	$coins/bitcoin_gold.self_modulate = normal_color

func _on_dash_mouse_entered():
	$coins/dash.self_modulate = hover_color

func _on_dash_mouse_exited():
	$coins/dash.self_modulate = normal_color

func _on_digibyte_mouse_entered():
	$coins/digibyte.self_modulate = hover_color

func _on_digibyte_mouse_exited():
	$coins/digibyte.self_modulate = normal_color

func _on_dogecoin_mouse_entered():
	$coins/dogecoin.self_modulate = hover_color

func _on_dogecoin_mouse_exited():
	$coins/dogecoin.self_modulate = normal_color

func _on_ethereum_mouse_entered():
	$coins/ethereum.self_modulate = hover_color

func _on_ethereum_mouse_exited():
	$coins/ethereum.self_modulate = normal_color

func _on_firo_mouse_entered():
	$coins/firo.self_modulate = hover_color

func _on_firo_mouse_exited():
	$coins/firo.self_modulate = normal_color

func _on_komodo_mouse_entered():
	$coins/komodo.self_modulate = hover_color

func _on_komodo_mouse_exited():
	$coins/komodo.self_modulate = normal_color

func _on_litecoin_mouse_entered():
	$coins/litecoin.self_modulate = hover_color

func _on_litecoin_mouse_exited():
	$coins/litecoin.self_modulate = normal_color

func _on_qtum_mouse_entered():
	$coins/qtum.self_modulate = hover_color

func _on_qtum_mouse_exited():
	$coins/qtum.self_modulate = normal_color

func _on_ravencoin_mouse_entered():
	$coins/ravencoin.self_modulate = hover_color

func _on_ravencoin_mouse_exited():
	$coins/ravencoin.self_modulate = normal_color

func _on_reddcoin_mouse_entered():
	$coins/reddcoin.self_modulate = hover_color

func _on_reddcoin_mouse_exited():
	$coins/reddcoin.self_modulate = normal_color

func _on_verge_mouse_entered():
	$coins/verge.self_modulate = hover_color

func _on_verge_mouse_exited():
	$coins/verge.self_modulate = normal_color

func _on_vertcoin_mouse_entered():
	$coins/vertcoin.self_modulate = hover_color

func _on_vertcoin_mouse_exited():
	$coins/vertcoin.self_modulate = normal_color

func _on_zcash_mouse_entered():
	$coins/zcash.self_modulate = hover_color

func _on_zcash_mouse_exited():
	$coins/zcash.self_modulate = normal_color

func _on_back_mouse_entered():
	$Back.self_modulate = hover_color

func _on_back_mouse_exited():
	$Back.self_modulate = normal_color

func _on_next_mouse_entered():
	$Next.self_modulate = hover_color

func _on_next_mouse_exited():
	$Next.self_modulate = normal_color
