class AddHostColumnsToUsers < ActiveRecord::Migration
  def change
  		add_column :users, :host, :integer
  end
end
