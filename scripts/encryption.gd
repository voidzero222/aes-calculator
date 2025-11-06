extends Node
class_name Encryption

func get_sbox_value(hex_in:String) -> String:
	#line edit in datagrid, wenn änderung dann erste stelle als zeile in sbox verwenden, zweite als index, 
	#nimmt einzelne hexadezimalzahlen
	var x:int = hex_in[0].hex_to_int()
	var y:int = hex_in[1].hex_to_int()
	return Constants.SBOX[x][y]
func rot_word(vector_in:Vector4i, times:int =1) -> Vector4i:
	if times == 0:
		return vector_in
	return rot_word(Vector4i(vector_in.y,vector_in.z,vector_in.w,vector_in.x),times -1)
func generate_round_keys():
	#gehirnfick
	pass
func shift_rows():
	pass
func mix_columns():
	pass
func add_round_key():
	pass
