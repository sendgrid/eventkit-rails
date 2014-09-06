
class CreateUsers < ActiveRecord::Migration
	def change
		create_table :users do |t|
			t.integer :permissions, :default => 1
			t.string :token
			t.string :username
			t.string :password
			t.timestamps
		end
	end
end
