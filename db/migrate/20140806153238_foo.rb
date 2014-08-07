class Foo < ActiveRecord::Migration
  def change
  	drop_table :candidate_votations
  end
end
