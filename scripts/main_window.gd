extends CanvasLayer

@onready var key_grid: GridContainer = $Control/HBoxContainer/InputVBox/InputKey/KeyGrid
@onready var data_grid: GridContainer = $Control/HBoxContainer/InputVBox/InputData/DataGrid


func _init():
	var grr = Encryption.new()
	print(grr.subbyte_array([
	PackedStringArray(["04","07"]),
	PackedStringArray(["16","12"]),
	]))
	#print(grr.mix_columns([
	#PackedStringArray(["d4","e0","b8","1e"]),
	#PackedStringArray(["bf","b4","41","27"]),
	#PackedStringArray(["5d","52","11","98"]),
	#PackedStringArray(["30","ae","f1","e5"]),
	#]))

func _ready() -> void:
	input_fields()
	
func input_fields() -> void:
	for grid: GridContainer in [key_grid,data_grid]:
		for i in 16:
			var line_edit: LineEdit = LineEdit.new()
			line_edit.text = "00"
			line_edit.max_length = 2
			line_edit.text_changed.connect(validate_lineedit_input.bind(line_edit))
			grid.add_child(line_edit)
	
func validate_lineedit_input(new_text: String, line_edit: LineEdit) -> void:
	var allowed_characters: String = "[a-f0-9]"
	var old_caret_position: int = line_edit.caret_column
	var word: String = ""
	var regex: RegEx = RegEx.new()
	regex.compile(allowed_characters)
	for valid_character in regex.search_all(new_text):
		word += valid_character.get_string()
	line_edit.set_text(word)
	line_edit.caret_column = old_caret_position


func _on_random_key_button_pressed() -> void:
	for child:LineEdit in key_grid.get_children():
		var hex: String = "%x" % randi_range(0,256)
		if hex.length() < 2:
			hex = "0" + hex
		child.text = hex
