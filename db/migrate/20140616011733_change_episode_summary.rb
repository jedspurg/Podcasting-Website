class ChangeEpisodeSummary < ActiveRecord::Migration
  def change
    change_column :episodes, :summary, :text, null: false
  end
end
