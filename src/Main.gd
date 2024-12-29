extends Control


func _ready() -> void:
	DB.recreate_tables()
	var post = DB.Post.create({ "title": "Test" })
	DB.Comment.create({ "post_id": post.id, "content": "this is test." })
	DB.Comment.create({ "post_id": post.id, "content": "this is test2." })
	render_posts()
	render_comments()


func render_posts() -> void:
	for post in DB.Post.all():
		%PostList.add_item("id: %s, title: %s" % [post.id, post.title])


func render_comments() -> void:
	for comment in DB.Comment.all():
		%CommentList.add_item(
			"id: %s, post_id: %s, content: %s" %
			[comment.id, comment.post_id, comment.content])
