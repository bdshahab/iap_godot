extends Control

'''
This program, through the website, checks the version of the program and if the version has not changed, 
it updates the necessary information.
You can test the program by activating the "test_IAP" function.
Set its parameter to "true" to test.
Also, the payment type must be Litecoin.
https://litecoinblockexplorer.net/tx/61a7667851da2d1395c26f4eaba7a14a3c1355ba80e1b35678327619a115d21e
'''
var TESTING = false
var PRICE_TEST_IS_OK = false
var DATE_TEST_IS_OK = false
var TIME_TEST_IS_OK = false
var BUY_CLICKED = false
var GITHUB = "https://raw.githubusercontent.com/bdshahab/iap_godot/main/"
var KEY_DATA_SITE = GITHUB + "key_data.txt"
# updatable key data
var IAP_VERSION = "3"
# To get the current Date & Time
var DATE_TIME_SITE = "https://unixtime.org"
var TIME_REGEX = "([0-2][0-9]:[0-5][0-9]:[0-5][0-9])"
var DATE_REGEX = "[0-9]+-[A-Z][a-z]+-[0-9]+"
var DATE_REMOVE = "-"
var DATE_REPLACE = " "
var CLOCK_REGEX = "([0-2][0-9]:[0-5][0-9]:[0-5][0-9])"

# To get the current price of coins
var PRICE_SITE = "https://cryptorank.io/price/"
var PRICE_SITE_REGEX = 'Price \\$ ([0-9]+\\.[0-9]+), Trading Volume'
var PRICE_SITE_PREFIX = ""
var PRICE_SITE_SUFFIX = ""
var COIN_REGEX_1 = "([^%(]+)" # '(%a+%s%a+) %(%a+%)' --'%((%a+)%)'
var COIN_REGEX_2 = ""
var COIN_UPPER_LOWER = "lower" #"lower" -- upper if uppercase and lower if lowercase and nothing("") for none
var COIN_REGEX_SEPARATOR = "-"

# To get the validation of payment
var ADDRESS_PREFIX = "/address/"
var ADDRESS_SUFFIX = "\">"
var TXID_PREFIX = ">" # and /tx/
var TXID_SUFFIX = "<"
var MONEY_PREFIX = ">"
var MONEY_SUFFIX = " "
var DATE_PREFIX = ", "
var DATE_SUFFIX = " "

var addresses = [
	["Bitcoin (BTC)", "1LQSzFZKE5vwiUS94toMG7r5M2nQ4X2muw", "https://bitcoinblockexplorers.com/tx/"],
	["Bitcoin Cash (BCH)", "bitcoincash:qzhr6lc9r64c3wg3jnndqaxzpyxeghdp2s57w5wgwu", "https://bchblockexplorer.com/tx/"],
	["Bitcoin Gold (BTG)", "GJbYu4YviyCi8azMV6ZAvdhjJTcigdmnPV", "https://btgexplorer.com/tx/"],
	["Dash (DASH)", "Xn5HwktiWJfgKydTDjodBTjJDA6tVxzAho", "https://dashblockexplorer.com/tx/"],
	["DigiByte (DGB)", "D97CQ5pV1AukRY1FJTSW3CFkJtUZgdwJq4", "https://digibyteblockexplorer.com/tx/"],
	["Dogecoin (DOGE)", "D5YP7CggUUkS3fu1B7RjhjJ7jvNu6A4Ksx", "https://dogeblocks.com/tx/"],
	["Ethereum (ETH)", "0x80D3CA7528cF05118131dBa3d7852Db2685c4b9E", "https://ethblockexplorer.org/tx/"],
	["FIRO (FIRO)", "a5R3Z4XBjj9oQS6kMgtfT5kMYMnA8Qx2Ga", "https://firoblockexplorers.com/tx/"],
	["Komodo (KMD)", "RQzp2jDRhRMrzBJZobGtUQhkQfcnfXdxWz", "https://komodoblockexplorer.com/tx/"],
	["Litecoin (LTC)", "LRQ6TBVXsEVPApbCY79bV1d9LR8E7JiuDd", "https://litecoinblockexplorer.net/tx/"],
	["Qtum (QTUM)", "QXFD7QitfegWXf4n4F9bVLU9HXqESgRVWq", "https://qtumblockexplorer.com/tx/"],
	["Ravencoin (RVN)", "RLMJbB268ayzGtJokjimNiLgdAccF8yv21", "https://rvnblockexplorer.com/tx/"],
	["ReddCoin (RDD)", "RvawiN6Ues4gxdu52JkKLQ7cKYSDDYwkUQ", "https://rddblockexplorer.com/tx/"],
	["Verge (XVG)", "DKY9rZfiw6qShLvWzKZCmuKJdiadDyhnVr", "https://xvgblockexplorer.com/tx/"],
	["Vertcoin (VTC)", "VmLS1YQuRVJT73ZkQyQNKWUPUCEsC95MSJ", "https://vtcblocks.com/tx/"],
	["Zcash (ZEC)", "t1gFJup6Mri4mZ1Pgqgzqmz2a3hg66Cpyga", "https://zecblockexplorer.com/tx/"],
]
const TOTAL_TIME = 15 * 60
var time_in_seconds = TOTAL_TIME
var MINIMUM_LIMIT_PRICE = 0.00000001
var APP_PRICE = 0.01 # in US Dollar
var timer_active = false
# for know dialogue action
var dialogue_action = ""
# Input data for verifying payment
var registered_txid = ""
var registered_address = ""
var registered_clock = ""
var registered_money = ""
var first_date = ""
var last_date = ""
var first_clock = ""
var last_clock = ""
# this one depends on selected coin
var price_site_middle = ""
# messages
var MESSAGE_PAYMENT_VERSION = "This payment method is not working anymore! Please download a new version of this program or contact the support section."
var MESSAGE_EXACT_PRICE = "You haven't paid exact price! Pay the amount not less or more before time runs out and enter its TXID."
var MESSAGE_ANOTHER_ADDRESS = "Your payment receipt was sent to another address and is not acceptable."
var MESSAGE_ANOTHER_CURRENCY = "Currently, payment with this digital currency is not possible. Choose another digital currency to pay."
var MESSAGE_ANOTHER_TIME = "Your payment receipt was registered at another time and is not acceptable."
var MESSAGE_ANOTHER_DATE = "Your payment receipt was registered on another date and is not acceptable."
var MESSAGE_TXID_NOT_EXIST = "Your transaction ID does not exist! Copy the transaction ID and then enter it in the desired place. Make sure your internet connection is also established."
var MESSAGE_EMPTY_TXID = "First, enter the TXID and then proceed to verify the purchase."
var MESSAGE_LOST_CONNECTION = "The Internet connection is lost! Try again or contact support in the [about] section."
var MESSAGE_HELP = "Once you know the price, go to your cryptocurrency account. Pay the price in that selected digital currency. After that, you must copy your payment's transaction hash ID (TXID). Then, go back to the program and paste the [TXID] in the bottom part. Press [Buy] button before time's up!"

func _ready():
	define_buttons()
	$timer.text = get_display_time(TOTAL_TIME)
	set_coin_icon()
	# if selected_payment is "ReddCoin (RDD)" and in the current situation, we use "RDD"
	# if price site codes will change, maybe we use "ReddCoin"
	# or maybe we use combination of them "ReddCoin RDD"
	# Godot is sensitive to lower/upper case
	price_site_middle = get_coin_symbol(Global.selected_payment)
	BUY_CLICKED = false
	get_web_content_from(KEY_DATA_SITE, "", "", "", http_key_data_function)

func http_key_data_function(result, response_code, _headers, body):
	connection_status(response_code)
	if result == HTTPRequest.RESULT_SUCCESS:
		var text = body.get_string_from_utf8()
		var num = 1
		# iterate over each line in the string text, capturing the content of each line without the newline character
		for line in text.split("\n"):
			if num == 1:
				if line != IAP_VERSION:
					show_dialogue("back", "back", MESSAGE_PAYMENT_VERSION)
					break
			elif num == 2:
				DATE_TIME_SITE = line
			elif num == 3:
				TIME_REGEX = line
			elif num == 4:
				DATE_REGEX = line
			elif num == 5:
				DATE_REMOVE = line
			elif num == 6:
				DATE_REPLACE = line
			elif num == 7:
				CLOCK_REGEX = line
			elif num == 8:
				PRICE_SITE = line
			elif num == 9:
				PRICE_SITE_REGEX = line
			elif num == 10:
				PRICE_SITE_PREFIX = line
			elif num == 11:
				PRICE_SITE_SUFFIX = line
			elif num == 12:
				COIN_REGEX_1 = line
			elif num == 13:
				COIN_REGEX_2 = line
			elif num == 14:
				COIN_UPPER_LOWER = line
			elif num == 15:
				COIN_REGEX_SEPARATOR = line
			elif num == 16:
				ADDRESS_PREFIX = line
			elif num == 17:
				ADDRESS_SUFFIX = line
			elif num == 18:
				TXID_PREFIX = line
			elif num == 19:
				TXID_SUFFIX = line
			elif num == 20:
				MONEY_PREFIX = line
			elif num == 21:
				MONEY_SUFFIX = line
			elif num == 22:
				DATE_PREFIX = line
			elif num == 23:
				DATE_SUFFIX = line
			num = num + 1
		get_web_content_from(PRICE_SITE, PRICE_SITE_PREFIX, price_site_middle, PRICE_SITE_SUFFIX, http_price_function)
	else:
		show_dialogue("back", "internet_lost", MESSAGE_LOST_CONNECTION)

func get_time_in_seconds(text_time: String) -> int:
	var time_parts: PackedStringArray = text_time.split(":")
	if int(time_parts[0]) == 0:
		time_parts[0] = "24"
	var h: int = int(time_parts[0]) * 60 * 60
	var m: int = int(time_parts[1]) * 60
	var s: int = int(time_parts[2])
	return (h + m + s)

func is_time_in_duration(text_time, first_time, last_time):
	var the_time = get_time_in_seconds(text_time)
	var the_first_time = get_time_in_seconds(first_time)
	var the_last_time = get_time_in_seconds(last_time)
	return the_time >= the_first_time and the_time <= the_last_time

func connection_status(code):
	if not(code >= 200 and code < 400):
		if registered_txid != "":
			show_dialogue("", "internet_lost", MESSAGE_LOST_CONNECTION)
		return

func http_date_time_function(result, response_code, _headers, body):
	connection_status(response_code)
	if result == HTTPRequest.RESULT_SUCCESS:
		var text = body.get_string_from_utf8()
		var time = format_by_regex(text, TIME_REGEX)
		var date = format_by_regex(text, DATE_REGEX)
		date = date.replace(DATE_REMOVE, DATE_REPLACE)
		$paste_txid.modulate = "ffffff"
		if registered_txid == "":
			first_date = date
			first_clock = time
			if TESTING:
				print("First Time format: " + time)
				TIME_TEST_IS_OK = is_valid_time_format(time)
				print("First Date format: " + date)
				DATE_TEST_IS_OK = is_valid_date_format(date)
		else:
			if TESTING:
				print("Second Time format: " + time)
				print("Second Date format: " + date)
			last_date = date
			last_clock = time
			verify()
	else:
		show_dialogue("back", "internet_lost", MESSAGE_LOST_CONNECTION)

func get_date_time():
	get_web_content_from(DATE_TIME_SITE, "", "", "", http_date_time_function)

func verify():
	var url_site = get_coin_explorer() + registered_txid
	get_web_content_from(url_site, "", "", "", http_verify_function)

func get_registered_clock(text):
	var clock = format_by_regex(text, CLOCK_REGEX)
	if clock == null:
		return ""
	else:
		return clock

func http_verify_function(result, response_code, _headers, body):
	connection_status(response_code)
	if result == HTTPRequest.RESULT_SUCCESS:
		var text = body.get_string_from_utf8()
		registered_clock = get_registered_clock(text)
		# test section (uncomment these for testing the verify section)
		# you have to set correct TXID in the app too.
		test_IAP(TESTING)
		# End of test section
		# real money comes to account is "Total Output"
		# Total Output => Total Input - Transaction Fee
		if text.find(ADDRESS_PREFIX + registered_address + ADDRESS_SUFFIX) != -1:
			if text.find(TXID_PREFIX + registered_txid + TXID_SUFFIX) != -1:
				if text.find(DATE_PREFIX + first_date + DATE_SUFFIX) != -1 or text.find(DATE_PREFIX + last_date + DATE_SUFFIX) != -1:
					if is_time_in_duration(registered_clock, first_clock, last_clock):
						if text.find(MONEY_PREFIX + registered_money + MONEY_SUFFIX) != -1:
							payment_successful()
						else:
							show_dialogue("", "money", MESSAGE_EXACT_PRICE)
					else:
						show_dialogue("", "clock", MESSAGE_ANOTHER_TIME)
				else:
					show_dialogue("", "calendar", MESSAGE_ANOTHER_DATE)
			else:
				show_dialogue("", "paste", MESSAGE_TXID_NOT_EXIST)
		else:
			show_dialogue("", "wallet", MESSAGE_ANOTHER_ADDRESS)
	else:
		show_dialogue("", "internet_lost", MESSAGE_LOST_CONNECTION)

func payment_successful():
	Global.user_bought = true
	get_tree().change_scene_to_file("res://Payment/You_Bought_this.tscn")
	if TESTING:
		if TIME_TEST_IS_OK and DATE_TEST_IS_OK:
			print("TEST was 100% successful.")
		elif TIME_TEST_IS_OK:
			print("Date test wasn't successful.")
		elif DATE_TEST_IS_OK:
			print("Time test wasn't successful.")

func paste_operation():
	var contents = remove_all_whitespaces(DisplayServer.clipboard_get())
	contents = split_string_by(contents, "/")
	if contents != null and len(contents) != 0:
		if typeof(contents) == TYPE_STRING:
			$txid.text = contents
		else:
			$txid.text = contents[-1]
			$HBoxContainer/buy.modulate = Color(1, 0, 1, 1)
	else:
		$txid.text = ""

	# Show the buy button if data is pasted
	if $txid.text != "" and $dialogue.modulate.a != 1.0:
		$HBoxContainer/buy.visible = true

func get_price_from_web(text):
	return format_by_regex(text, PRICE_SITE_REGEX)

func sub_http_price(number):
	number = APP_PRICE / number
	# Converting a number to text format helps to show it in normal mode not in scientific notation.
	# For example, instead of (1.5e-07), we want (0.00000015)
	var number_in_text = convert_exponential_to_normal(number)
	number = float(number_in_text)
	if number < MINIMUM_LIMIT_PRICE:
		show_dialogue("back", "methods", MESSAGE_ANOTHER_CURRENCY)
	else:
		$text_price.text = number_in_text
		counting_timer()
		get_date_time()

func http_price_function(result, response_code, _headers, body):
	connection_status(response_code)
	PRICE_TEST_IS_OK = false
	if result == HTTPRequest.RESULT_SUCCESS:
		PRICE_TEST_IS_OK = false
		var text = body.get_string_from_utf8()
		var number = get_just_number(get_price_from_web(text))
		if number != null:
			PRICE_TEST_IS_OK = true
			sub_http_price(number)
		else:
			var coin_str = Global.selected_payment.replace(" ", "%20")
			get_web_content_from(GITHUB, "default%20prices/", coin_str,".txt", http_default_price_function)
	else:
		show_dialogue("back", "internet_lost", MESSAGE_LOST_CONNECTION)

func http_default_price_function(result, code, _response_headers, body):
	connection_status(code)
	if result == HTTPRequest.RESULT_SUCCESS:
		var number = body.get_string_from_utf8()
		number = get_just_number(number)
		if number != null:
			sub_http_price(number)
		else:
			show_dialogue("back", "internet_lost", MESSAGE_LOST_CONNECTION)

func get_coin_symbol(text):
	var result = ""
	if COIN_REGEX_1 != "":
		var sub_str = format_by_regex(text, COIN_REGEX_1)
		if sub_str != null:
			result = result + sub_str

	# Remove the blank space at the beginning and end of the text
	result = result.strip_edges()

	if COIN_REGEX_2 != "":
		result = result + format_by_regex(text, COIN_REGEX_2)

	if result.find(" ") != -1:
		result = result.replace(" ", COIN_REGEX_SEPARATOR)

	if COIN_UPPER_LOWER == "upper":
		result = result.to_upper()
	elif COIN_UPPER_LOWER == "lower":
		result = result.to_lower()
	return result

func get_web_content_from(main_site, site_prefix, site_middle, site_suffix, http_call_function):
	# Create a new HTTPRequest node
	var http_request = HTTPRequest.new()
	# Add it as a child of the current node
	add_child(http_request)
	# Connect the request_completed signal
	http_request.request_completed.connect(http_call_function)
	# Make the HTTP request
	var error = http_request.request(main_site + site_prefix + site_middle + site_suffix)
	if error != OK:
		if (main_site + site_prefix + site_middle + site_suffix).begins_with(PRICE_SITE):
			var coin_str = Global.selected_payment.replace(" ", "%20")
			get_web_content_from(GITHUB, "default%20prices/", coin_str,".txt", http_default_price_function)
		else:
			show_dialogue("", "internet_lost", MESSAGE_LOST_CONNECTION)

func get_display_time(number_seconds:int):
	var sec = number_seconds % 60
	var minute = floor(number_seconds / 60)
	return ("%02d" % minute + ":%02d" % sec)

func hide_dialogue():
	get_node("dialogue").modulate = "ffffff00"

func show_dialogue(action, icon, text):
	get_node("dialogue/ok_dialogue").mouse_filter = MOUSE_FILTER_STOP
	get_node("dialogue/ok_dialogue/ColorRect").mouse_filter = MOUSE_FILTER_IGNORE
	BUY_CLICKED = false
	dialogue_action = action
	get_node("dialogue/text_dialogue").set_text(text)
	get_node("dialogue/logo_dialogue").texture = load("res://Payment/Photos/" + icon + ".png")
	$dialogue.modulate = "ffffff"

func timer():
	if timer_active:
		time_in_seconds -= 1
		$timer.text = get_display_time(time_in_seconds)
		if time_in_seconds > 2 * (TOTAL_TIME / 3):
			$timer.self_modulate = "0000ff"
		elif time_in_seconds > (TOTAL_TIME / 3):
			$timer.self_modulate = "00ff00"
		else:
			$timer.self_modulate = "ff0000"
		# check if the timer reaches the maximum value
		if time_in_seconds <= 0:
			# stop the timer and do something
			timer_active = false
			go_back()

func go_next():
	if not BUY_CLICKED:
		BUY_CLICKED = true
	else:
		return
	if $txid.text == "" and $dialogue.modulate.a != 1.0:
		show_dialogue("", "paste", MESSAGE_EMPTY_TXID)
	else:
		registered_address = $text_address.text
		registered_txid = $txid.text
		registered_money = $text_price.text
		get_date_time()

func set_coin_icon():
	$selected_payment_icon.texture_normal = load("res://Payment/Photos/" + Global.selected_payment.to_lower() + ".png")
	for i in range(addresses.size()):
		if addresses[i][0] == Global.selected_payment:
			$text_address.text = addresses[i][1]
			break

func get_coin_explorer():
	var url_explorer = ""
	for i in range(addresses.size()):
		if addresses[i][0] == Global.selected_payment:
			url_explorer = addresses[i][2]
			break
	return url_explorer

func counting_timer():
	timer_active = true
	$Timer.start()

func go_back():
	get_tree().change_scene_to_file("res://Payment/select_coin.tscn")

func get_just_number(text):
	if text != null and len(text) != 0:
		# Use a regular expression to extract all the numeric characters
		var numbers = RegEx.new()
		var pattern = "[0-9]+,*([0-9])*.*[0-9]+"
		numbers.compile(pattern)
		var result = numbers.search_all(text)
		# Join the extracted numbers into a single string
		var number_string = result[0].get_string()
		var temp = number_string.replace(",", "")
		return float(temp)
	else:
		return null

func remove_all_whitespaces(temp):
	var regex = RegEx.new()
	regex.compile("\\S+") # Negated whitespace character class.
	var final_str = ""
	for result in regex.search_all(temp):
		final_str += result.get_string()
	return final_str

func split_string_by(text, split_char):
	return text.split(split_char)

func define_buttons():
	get_node("dialogue/ok_dialogue").mouse_filter = MOUSE_FILTER_IGNORE
	$dialogue.modulate = "ffffff00"
	$paste_txid.modulate = "ffffff00"
	$HBoxContainer/buy.modulate = "ffffff00"

func is_valid_time_format(text_time):
	var regex = RegEx.new()
	regex.compile("^([01]?[0-9]|2[0-9]):[0-5][0-9]:[0-5][0-9]$")
	var result = regex.search(text_time)
	return result != null

func is_valid_date_format(date_str):
	var date_parts = split_string_by(date_str, " ")
	if date_parts[0].is_valid_int() == false or int(date_parts[0]) < 1 or int(date_parts[0]) > 31:
		return false
	if date_parts[1].is_valid_int() != false or len(date_parts[1]) != 3:
		return false
	if date_parts[2].is_valid_int() == false or len(date_parts[2]) < 4: # len(str(OS.get_date().year))
		return false
	return true

func convert_exponential_to_normal(text_num):
	text_num = str(text_num).to_lower()
	if "e" in text_num:
		var parts = text_num.split("e")
		var mantissa = float(parts[0])
		var exponent = int(parts[1])
		var decimal_part = mantissa * pow(10, exponent)
		return("%.8f" % decimal_part)
	else:
		return ("%.8f" % float(text_num))

func _on_payment_version_dialog_confirmed():
	get_tree().change_scene_to_file("res://About/about.tscn")

func format_by_regex(text, regex_pattern):
	var regex = RegEx.new()
	# We have to reconfigure special character($)
	regex_pattern = regex_pattern.replace("$", "\\$")
	regex.compile(regex_pattern)
	var result = regex.search(text)
	if result:
		return result.get_string()
	else:
		return text

func _on_selected_payment_icon_pressed():
	OS.shell_open("https://duckduckgo.com/?q=cryptocurrency " + Global.selected_payment)

func _on_copy_wallet_address_button_down():
	$copy_wallet_address.self_modulate = "6071cf"

func _on_copy_wallet_address_button_up():
	$copy_wallet_address.self_modulate = "aad8f7"

func _on_copy_wallet_address_pressed():
	DisplayServer.clipboard_set($text_address.text)

func _on_copy_wallet_address_mouse_entered():
	$copy_wallet_address.self_modulate = "aad8f7"

func _on_copy_wallet_address_mouse_exited():
	$copy_wallet_address.self_modulate = "ffffff"

func _on_copy_price_button_down():
	$copy_price.self_modulate = "6071cf"

func _on_copy_price_button_up():
	$copy_price.self_modulate = "aad8f7"

func _on_copy_price_pressed():
	DisplayServer.clipboard_set($text_price.text)

func _on_copy_price_mouse_entered():
	$copy_price.self_modulate = "aad8f7"

func _on_copy_price_mouse_exited():
	$copy_price.self_modulate = "ffffff"

func _on_paste_txid_button_down():
	$paste_txid.self_modulate = "6071cf"	

func _on_paste_txid_button_up():
	$paste_txid.self_modulate = "929fe8"

func _on_paste_txid_pressed():
	if $paste_txid.modulate.a != 0:
		paste_operation()

func _on_paste_txid_mouse_entered():
	$paste_txid.self_modulate = "929fe8"

func _on_paste_txid_mouse_exited():
	$paste_txid.self_modulate = "ffffff"

func _on_help_button_down():
	$HBoxContainer/help.self_modulate = "3e7b4c"

func _on_help_pressed():
	show_dialogue("", "help", MESSAGE_EXACT_PRICE)

func _on_help_mouse_entered():
	$HBoxContainer/help.self_modulate = "6ec983"

func _on_help_mouse_exited():
	$HBoxContainer/help.self_modulate = "ffffff"

func _on_copy_all_button_down():
	$HBoxContainer/copy_all.self_modulate = "6071cf"

func _on_copy_all_button_up():
	$HBoxContainer/copy_all.self_modulate = "aad8f7"

func _on_copy_all_pressed():
	DisplayServer.clipboard_set(Global.selected_payment + "\n" + $text_address.text + "\n" + $text_price.text + "\n" + $txid.text)

func _on_copy_all_mouse_entered():
	$HBoxContainer/copy_all.self_modulate = "aad8f7"

func _on_copy_all_mouse_exited():
	$HBoxContainer/copy_all.self_modulate = "ffffff"

func _on_exit_help_button_down():
	$Help_section/Exit_help.self_modulate = "6071cf"

func _on_exit_help_pressed():
	$Help_section.hide()

func _on_exit_help_mouse_entered():
	$Help_section/Exit_help.self_modulate = "aad8f7"

func _on_exit_help_mouse_exited():
	$Help_section/Exit_help.self_modulate = "ffffff"

func _on_price_dialog_confirmed():
	go_back()

func _on_back_pressed():
	go_back()

func _on_back_button_down():
	$HBoxContainer/back.self_modulate = "6071cf"

func _on_back_mouse_exited():
	$HBoxContainer/back.self_modulate = "ffffff"

func _on_back_mouse_entered():
	$HBoxContainer/back.self_modulate = "aad8f7"

func _on_buy_button_down():
	if not $HBoxContainer/buy.disabled:
		$HBoxContainer/buy.self_modulate = "0b70ff"

func _on_buy_button_up():
	if not $HBoxContainer/buy.disabled:
		$HBoxContainer/buy.self_modulate = "fb2da6"

func _on_buy_mouse_entered():
	if not $HBoxContainer/buy.disabled:
		$HBoxContainer/buy.self_modulate = "fb2da6"

func _on_buy_mouse_exited():
	if not $HBoxContainer/buy.disabled:
		$HBoxContainer/buy.self_modulate = "c40bff"

func _on_ok_dialogue_pressed():
	if $HBoxContainer/buy.modulate != Color(1, 0, 1, 1):
		go_back()
	else:
		hide_dialogue()

func _on_buy_pressed():
	if $HBoxContainer/buy.modulate == Color(1, 0, 1, 1) and $dialogue.modulate.a != 1.0:
		go_next()

func _on_timer_timeout():
	timer()

func test_IAP(value):
	'''
	This is for testing this payment method.
	You have to select Litecoin and set the TXID.
	We're using this payment from this website:
	https://litecoinblockexplorer.net/tx/61a7667851da2d1395c26f4eaba7a14a3c1355ba80e1b35678327619a115d21e
	txid = "61a7667851da2d1395c26f4eaba7a14a3c1355ba80e1b35678327619a115d21e"
	address = "LRQ6TBVXsEVPApbCY79bV1d9LR8E7JiuDd"
	registered_clock = "07:05:47"

	"Total Input" is the total amount of money the user paid.
	"Transaction Fee" is the amount of money the user paid for that transaction.
	"Total Output" is the amount of money the producer receives.
	In summary:
	Total Output == Total Input - Transaction Fee
	'''
	if value == false:
		return

	print("Data:")
	print("PRICE_TEST_IS_OK: ", PRICE_TEST_IS_OK)
	print("registered_address: ", registered_address)
	print("registered_txid: ", registered_txid)
	print("registered_clock: ", registered_clock) # 07:05:47

	print("Data before change:")
	print("registered_money: ", registered_money)
	print("first_date: ", first_date)
	print("last_date: ", last_date)
	print("first_clock: ", first_clock)
	print("last_clock: ", last_clock)

	registered_money = "0.00994753"
	first_date = "08 Feb 2022"
	last_date = "09 Feb 2022"
	first_clock = "07:00:00"
	last_clock = "07:10:00"

	print("Data After change:")
	print("registered_money: ", registered_money)
	print("first_date: ", first_date)
	print("last_date: ", last_date)
	print("first_clock: ", first_clock)
	print("last_clock: ", last_clock)
	print("Result of test:")

	var result_of_test = false

	if registered_address == "LRQ6TBVXsEVPApbCY79bV1d9LR8E7JiuDd":
		if registered_txid == "61a7667851da2d1395c26f4eaba7a14a3c1355ba80e1b35678327619a115d21e":
			if registered_clock == "07:05:47":
				if registered_address == "LRQ6TBVXsEVPApbCY79bV1d9LR8E7JiuDd":
					if registered_money == "0.00994753":
						if first_date == "08 Feb 2022":
							if last_date == "09 Feb 2022":
								if TIME_TEST_IS_OK:
									if DATE_TEST_IS_OK:
										if is_time_in_duration(registered_clock, first_clock, last_clock):
											result_of_test = true

	if not TIME_TEST_IS_OK:
		print("time format is not correct.")
	if not DATE_TEST_IS_OK:
		print("date format is not correct.")

	if result_of_test and PRICE_TEST_IS_OK:
		print("Congratulations! The test was successful!")
	elif result_of_test:
		print("Only Verifying part was successful.")
	elif PRICE_TEST_IS_OK:
		print("Only the price test from the main site was successful.")
	else:
		print("Sorry! The test was unsuccessful.")
