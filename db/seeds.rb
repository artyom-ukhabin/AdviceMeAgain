# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#TODO: rewrite this lol
User.create!(email: 'admin@example.com', role: :admin, password: 'password', password_confirmation: 'password')
User.create!(email: 'test_1@example.com', role: :regular, password: 'password', password_confirmation: 'password')
User.create!(email: 'test_2@example.com', role: :regular, password: 'password', password_confirmation: 'password')
Book.create!(name: 'Good Book', genre: 'drama', year: '1999', info: 'such a good book')
track1 = Track.create!(name: 'track 1')
track2 = Track.create!(name: 'track 2')
album = Album.create!(name: 'our first album', tracks: [track1, track2])
Band.create!(name: 'Band1', genre: 'fak eeee rock', year: '2000', info: 'awesome band', albums: [album])
Movie.create!(name: 'Good Movie', genre: 'comedy', year: '2010', info: 'nah not a good honestly', timing: 180)
platform = Platform.create(name: 'PC')
Game.create!(name: 'Good Game', genre: 'action', year: '2005', info: 'such a good game', platforms: [platform])
