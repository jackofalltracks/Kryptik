
puts 'CREATING ROLES'
Role.create([
	{ name: 'fan' },
	{ name: 'artist' }, 
	{ name: 'admin'}
], :without_protection => true)

# puts 'SETTING UP DEFAULT USER LOGIN'
# user = User.create!(email: "thefounder@detroitrails.co", password: "please")
# user = User.create!( email: 'thefounder@detroitrails.co', password: 'Ethan2012', password_confirmation: 'Ethan2012', profile_name: "Detroit" )

# puts '------------'
# puts '------------'
# puts '------------'
# puts '------------'

# puts 'New user created: ' << user.email

# puts '------------'
# puts '------------'
# puts '------------'
# puts '------------'

# puts 'ADDING ADMIN ROLE!'

# puts '------------'
# puts '------------'
# puts '------------'
# puts '------------'

# user.add_role :admin
# user.add_role :band_member

# puts '------------'
# puts '------------'
# puts '------------'
# puts '------------'

# puts 'User now has Role: ' << user.roles.first.name

# puts '------------'
# puts '------------'
# puts '------------'
# puts '------------'

# puts 'User now has Role: ' << user.roles.last.name

# puts '------------'
# puts '------------'
# puts '------------'
# puts '------------'

# u = User.where(:profile_name => "DetroitRails")
# u.add_role :producer
# puts u.roles.first.name