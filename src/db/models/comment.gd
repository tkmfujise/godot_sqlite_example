extends DB_Table
func table_name() -> String: return 'comments'

func recordize(json: Dictionary): return recordize_by(Record, json)
class Record extends DB_Record:
	var id : int
	var post_id : int
	var content : String
	func column_names(): return ['id', 'post_id', 'content']


func schema() -> Dictionary:
	var dict = Dictionary()
	dict["id"] = {"data_type":"int", "primary_key": true, "auto_increment": true, "not_null": true}
	dict["post_id"] = {"data_type":"int", "foreign_key": "posts.id", "not_null": true}
	dict["content"] = {"data_type":"text", "not_null": true}
	return dict
