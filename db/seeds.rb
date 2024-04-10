# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# Clear existing data
User.destroy_all
Event.destroy_all

# Create users
users = []
10.times do
  name = Faker::Name.unique.name
  email = Faker::Internet.unique.email
  password = Faker::Internet.password(min_length: 8)

  users << User.create!(
    name: name,
    email: email,
    password: password
  )

  puts "User created: #{email} - #{password}"
end

# Create events with RSVPs
users.each do |user|
  3.times do
    title = Faker::Lorem.sentence
    description = Faker::Lorem.paragraph
    date_time = Faker::Time.between(from: DateTime.now, to: DateTime.now + 30, format: :default)
    location = Faker::Address.full_address

    event = user.created_events.create!(
      title: title,
      description: description,
      date_time: date_time,
      location: location
    )

    puts "Event created: #{event.title} at #{event.location} on #{event.date_time}"

    # Generate RSVPs for each event
    event_attendees = users.sample(rand(1..users.length))
    event_attendees.each do |attendee|
      unless attendee == user || event.attendees.include?(attendee)
        event.attendees << attendee
        puts "RSVP created: #{attendee.email} attending #{event.title}"
      end
    end
  end
end
