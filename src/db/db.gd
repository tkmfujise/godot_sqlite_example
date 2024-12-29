extends Node
# class_name DB defined in autoloads

var path := "res://data/sqlite-example"
const verbosity_level : int = SQLite.VERBOSE
var conn : SQLite

# Model
const _PostModel  = preload("res://src/db/models/post.gd")
const _CommentModel = preload("res://src/db/models/comment.gd")
@onready var Post  	 = _PostModel.new()
@onready var Comment = _CommentModel.new()


func _ready() -> void:
	open()


func open(_path: String = path) -> void:
	conn = SQLite.new()
	conn.path = _path
	conn.verbosity_level = verbosity_level
	conn.foreign_keys = true
	conn.open_db()


func reopen(new_path: String) -> void:
	close()
	open(new_path)


func close() -> void:
	conn.close_db()


func recreate_tables() -> void:
	DB.Comment.recreate_table()
	DB.Post.recreate_table()
