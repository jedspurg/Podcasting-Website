class AlterEpisodes < ActiveRecord::Migration
  def change
    remove_column :episodes, :user_id, :integer
    add_column :episodes, :pub_date, :date, :null => false
    add_column :episodes, :author, :string, :null => false
  end
end
