require "faker"

puts "🧹 Cleaning database..."
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

puts "🎬 Creating fake movies..."

20.times do
  Movie.create!(
    title: Faker::Movie.unique.title,
    overview: Faker::Lorem.paragraph(sentence_count: 3),
    poster_url: "https://picsum.photos/600/900?random=#{rand(1..10000)}"
  )
end

puts "✅ 20 movies created successfully!"
