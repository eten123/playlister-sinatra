# Add seed data here. Seed your database with `rake db:seed`

puts "Deleting songs"
Song.destroy_all

puts "Deleting artist"
Artist.destroy_all

  
puts "Deleting genres"
Genre.destroy_all

puts "Deleting Song Genres"
SongGenre.destroy_all

puts "Creating songs"

50.times do
  Song.create(name: Faker::Name.name, artist_id: Faker::IDNumber.valid.to_s)
end

puts "Seeded songs!"

puts "Creating artists"

50.times do
  Artist.create(name: Faker::Music::Hiphop.name)
end

puts "Done creating artists!"

puts "Creating genres"

50.times do
  Genre.create(name: Faker::Music.genre)
end

puts "Seeded genres!"

puts "Creating Song Genres"

50.times do
  SongGenre.create(song_id: rand(1..100), genre_id: rand(1..100))
end

puts "Done creating Song Genres!"