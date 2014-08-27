class RemoveIndex < ActiveRecord::Migration
  def change
		sql = 'DROP INDEX index_users_on_email'
  	#sql << ' ON users' if Rails.env == 'production' # Heroku pg
  	ActiveRecord::Base.connection.execute(sql)
		change_column :users, :email, :string, :null => true
  end
end
