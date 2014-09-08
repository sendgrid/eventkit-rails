# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


# Setup Default Settings
#=========================================================================#

Setting.create({
	name: "is_setup",
	value: "0",
	visible: 0
})

Setting.create({
	name: "autodelete_time",
	value: "6",
	visible: 1
})