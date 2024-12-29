extends GutTest

func before_each():
	DB.reopen("res://data/sqlite-example.test")
	DB.recreate_tables()


func test_count_if_nothing():
	assert_eq(DB.Post.count(), 0)


func test_create():
	var record = DB.Post.create({ "title": "foo" })
	assert_eq(DB.Post.count(), 1)
	assert_eq(record.attributes()['title'], 'foo')
	assert_eq(record.title, 'foo')
	record = DB.Post.first()
	assert_eq(record.attributes()['title'], 'foo')


func test_where():
	DB.Post.create({ "title": "foo" })
	assert_eq(DB.Post.where("title = 'bar'"), [])
	assert_eq(DB.Post.where("title = 'foo'").size(), 1)
	assert_eq(DB.Post.where("title = 'foo'")[0].title, 'foo')


func test_first_if_nothing():
	assert_eq(DB.Post.first(), null)
	assert_eq(DB.Post.first(2), [])


func test_first_if_one():
	DB.Post.create({ "title": "foo" })
	assert_eq(DB.Post.first().title, 'foo')
	assert_eq(DB.Post.first(2).size(), 1)
	assert_eq(DB.Post.first(2)[0].title, 'foo')


func test_first_if_multi():
	DB.Post.create({ "title": "foo" })
	DB.Post.create({ "title": "bar" })
	DB.Post.create({ "title": "piyo" })
	assert_eq(DB.Post.first().title, 'foo')
	assert_eq(DB.Post.first(2).size(), 2)
	assert_eq(DB.Post.first(2)[-1].title, 'bar')


func test_last_if_nothing():
	assert_eq(DB.Post.last(), null)
	assert_eq(DB.Post.last(2), [])


func test_last_if_one():
	DB.Post.create({ "title": "foo" })
	assert_eq(DB.Post.last().title, 'foo')
	assert_eq(DB.Post.last(2).size(), 1)
	assert_eq(DB.Post.last(2)[0].title, 'foo')


func test_last_if_multi():
	DB.Post.create({ "title": "foo" })
	DB.Post.create({ "title": "bar" })
	DB.Post.create({ "title": "piyo" })
	assert_eq(DB.Post.last().title, 'piyo')
	assert_eq(DB.Post.last(2).size(), 2)
	assert_eq(DB.Post.last(2)[0].title, 'bar')


func test_update():
	var record = DB.Post.create({ "title": "test" })
	record.update({ "title": "bar" })
	assert_eq(record.title, 'bar')
	record = DB.Post.first()
	assert_eq(record.title, 'bar')


func test_save():
	var record = DB.Post.create({ "title": "test" })
	record.title = 'bar'
	record.save()
	assert_eq(record.title, 'bar')
	record = DB.Post.first()
	assert_eq(record.title, 'bar')


func test_destroy():
	var record = DB.Post.create({ "title": "test" })
	assert_eq(DB.Post.count(), 1)
	record.destroy()
	assert_eq(DB.Post.count(), 0)


func test_delete_all():
	DB.Post.create({ "title": "test" })
	assert_eq(DB.Post.count(), 1)
	DB.Post.delete_all()
	assert_eq(DB.Post.count(), 0)
