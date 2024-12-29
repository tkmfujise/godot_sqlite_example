extends DB_Table
func table_name() -> String: return 'posts'

func recordize(json: Dictionary): return recordize_by(Record, json)
class Record extends DB_Record:
	var id : int
	var title : String
	func column_names(): return ['id', 'title']


func schema() -> Dictionary:
	var dict = Dictionary()
	dict["id"] = {"data_type":"int", "primary_key": true, "auto_increment": true, "not_null": true}
	dict["title"] = {"data_type":"text", "not_null": true}
	return dict
