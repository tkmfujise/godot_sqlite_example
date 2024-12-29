extends GutTest

var post
var attributes

func before_each():
	DB.reopen("res://data/sqlite-example.test")
	DB.recreate_tables()
	post = DB.Post.create({ "title": "bar" })


func attr(dict: Dictionary) -> Dictionary:
	var attributes = { "post_id": post.id }
	attributes.merge(dict)
	return attributes


func test_count_if_nothing():
	assert_eq(DB.Comment.count(), 0)


func test_create():
	var record = DB.Comment.create(attr({ "content": "foo" }))
	assert_eq(DB.Comment.count(), 1)
	assert_eq(record.attributes()['content'], 'foo')
	assert_eq(record.content, 'foo')
	record = DB.Comment.first()
	assert_eq(record.attributes()['content'], 'foo')


func test_where():
	DB.Comment.create(attr({ "content": "foo" }))
	assert_eq(DB.Comment.where("content = 'bar'"), [])
	assert_eq(DB.Comment.where("content = 'foo'").size(), 1)
	assert_eq(DB.Comment.where("content = 'foo'")[0].content, 'foo')


func test_first_if_nothing():
	assert_eq(DB.Comment.first(), null)
	assert_eq(DB.Comment.first(2), [])


func test_first_if_one():
	DB.Comment.create(attr({ "content": "foo" }))
	assert_eq(DB.Comment.first().content, 'foo')
	assert_eq(DB.Comment.first(2).size(), 1)
	assert_eq(DB.Comment.first(2)[0].content, 'foo')


func test_first_if_multi():
	DB.Comment.create(attr({ "content": "foo" }))
	DB.Comment.create(attr({ "content": "bar" }))
	DB.Comment.create(attr({ "content": "piyo" }))
	assert_eq(DB.Comment.first().content, 'foo')
	assert_eq(DB.Comment.first(2).size(), 2)
	assert_eq(DB.Comment.first(2)[-1].content, 'bar')


func test_last_if_nothing():
	assert_eq(DB.Comment.last(), null)
	assert_eq(DB.Comment.last(2), [])


func test_last_if_one():
	DB.Comment.create(attr({ "content": "foo" }))
	assert_eq(DB.Comment.last().content, 'foo')
	assert_eq(DB.Comment.last(2).size(), 1)
	assert_eq(DB.Comment.last(2)[0].content, 'foo')


func test_last_if_multi():
	DB.Comment.create(attr({ "content": "foo" }))
	DB.Comment.create(attr({ "content": "bar" }))
	DB.Comment.create(attr({ "content": "piyo" }))
	assert_eq(DB.Comment.last().content, 'piyo')
	assert_eq(DB.Comment.last(2).size(), 2)
	assert_eq(DB.Comment.last(2)[0].content, 'bar')


func test_update():
	var record = DB.Comment.create(attr({ "content": "test" }))
	var att = record.attributes()
	record.update(attr({ "content": "bar" }))
	assert_eq(record.content, 'bar')
	record = DB.Comment.first()
	assert_eq(record.content, 'bar')


func test_save():
	var record = DB.Comment.create(attr({ "content": "test" }))
	record.content = 'bar'
	record.save()
	assert_eq(record.content, 'bar')
	record = DB.Comment.first()
	assert_eq(record.content, 'bar')


func test_destroy():
	var record = DB.Comment.create(attr({ "content": "test" }))
	assert_eq(DB.Comment.count(), 1)
	record.destroy()
	assert_eq(DB.Comment.count(), 0)


func test_delete_all():
	DB.Comment.create(attr({ "content": "test" }))
	assert_eq(DB.Comment.count(), 1)
	DB.Comment.delete_all()
	assert_eq(DB.Comment.count(), 0)
