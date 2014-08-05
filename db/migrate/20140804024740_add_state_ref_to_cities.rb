class AddStateRefToCities < ActiveRecord::Migration
  def change
    add_reference :cities, :state, index: true
  end
end
