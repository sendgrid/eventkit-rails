class CreateSettings < ActiveRecord::Migration
	def change
		create_table :settings do |t|
			t.string :name
			t.text :value
			t.timestamps
		end
	end
end
