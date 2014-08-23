namespace :db do
	task :populate => :environment do
		require 'populator'
		require 'faker'

		User.delete_all
		u=User.new(:email => "ewilliams@tegik.com", :password => '12345678', :password_confirmation => '12345678', 
			:role => 'admin', :name => "Eduardo", :last_name => "Hinojosa", :first_name=>"Williams",
			:cellphone => '8180291458', :phone => '8180291458', :rnm => '190KD09',
			:section => 'Centro', :zipcode => '3700', :cp => '3700',
			:register_date => DateTime.now, :bird => DateTime.now, :sector => 'Publico',
			:age => 31, :gender => 'h', :city => 'Monterrey', :street_number => '908',
			:neighborhood => 'Narvarte',:parent => 0)
		u.save
		User.populate 200 do |user|
			user.email = 	Faker::Internet.email
			user.name = Faker::Name.name
			user.first_name = Faker::Name.first_name
			user.last_name = Faker::Name.last_name
			user.cellphone = Faker::PhoneNumber.cell_phone
			user.rnm = Faker::Code.isbn
			user.parent = [User.first.id, User.last.id, 0]
			user.section = ['Centro', 'Norte', 'Sur']
			user.zipcode = Faker::Address.zip_code
			user.role = ['jugador', 'subenlace', 'enlace', 'coordinador', 'grupo']
			user.cp = Faker::Address.zip_code
			user.register_date = DateTime.now
			user.bird = DateTime.now
 			user.sector = ['Publico', 'Privado']
			user.phone = Faker::PhoneNumber.phone_number.to_s
			user.age = 1..70
			user.gender = ['h','m']
			user.city = Faker::Address.city
			user.street_number = Faker::Address.building_number
			user.neighborhood = Faker::Address.street_address
			user.encrypted_password = u.encrypted_password
			user.sign_in_count=0
		end
	end
end