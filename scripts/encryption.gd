extends Node
class_name Encryption
	
func get_sbox_value(hex_in:String) -> String:
	var x:int = hex_in[0].hex_to_int()
	var y:int = hex_in[1].hex_to_int()
	return Constants.SBOX[x][y]
func rot_word(array_in:PackedStringArray, times:int =1) -> PackedStringArray:
	if times == 0:
		return array_in
	return rot_word(PackedStringArray([array_in[1],array_in[2],array_in[3],array_in[0]]),times -1)
func generate_round_keys():
	#gehirnfick
	pass
func shift_rows(matrix_in: Array[PackedStringArray]) -> Array[PackedStringArray]:
	matrix_in = matrix_in.duplicate(true)
	for i in 4:
		var row:PackedStringArray = matrix_in[i]
		row = rot_word(row,i)
		matrix_in[i] = row
	return matrix_in
func mix_columns(matrix_in:Array[PackedStringArray]) -> Array[PackedStringArray]:
	matrix_in = matrix_in.duplicate()
	for i in 4:
		var column:Array[int] = [matrix_in[0][i].hex_to_int(),matrix_in[1][i].hex_to_int(),
		matrix_in[2][i].hex_to_int(),matrix_in[3][i].hex_to_int()]
		for row in Constants.GALOIS_FIELD:
			var mixed_column:Array[int] = [mod(column[0]*row[0],256),mod(column[1]*row[1],256),
			mod(column[2]*row[2],256),mod(column[3]*row[3],256)]
			matrix_in[0][i] = "%x" % mixed_column[0]
			matrix_in[1][i] = "%x" % mixed_column[1]
			matrix_in[2][i] = "%x" % mixed_column[2]
			matrix_in[3][i] = "%x" % mixed_column[3]
	return matrix_in

func add_round_key():
	pass
