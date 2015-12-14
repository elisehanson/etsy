class User < ActiveRecord::Base
	attr_accessor :shop_name

	attr_accessor :password
	validates_confirmation_of :password
	before_save :encrypt_password

	def encrypt_password
		self.password_salt = BCrypt::Engine.generate_salt
		self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
	end

	def self.authenticate(email, password)

		user = User.where(email: email).first
		if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
			user
		else
			nil
		end
	end


has_attached_file :image, styles: { small: "64x64>", med: "100x100>", large: "500x500>" }

validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/


end
