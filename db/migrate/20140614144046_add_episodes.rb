class AddEpisodes < ActiveRecord::Migration
  def change
    create_table :episodes do |t|
      t.string      :title, :null => false
      t.references  :user, :null => false
      t.string      :subtitle, :null => false
      t.string      :summary, :null => false
      t.attachment  :image
      t.attachment  :audio

      t.timestamps
    end
  end
end
