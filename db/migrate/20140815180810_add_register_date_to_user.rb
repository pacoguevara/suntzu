class AddRegisterDateToUser < ActiveRecord::Migration
  def change
    add_column :users, :register_date, :datetime
  end
end
