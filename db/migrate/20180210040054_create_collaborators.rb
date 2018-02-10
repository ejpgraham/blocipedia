class CreateCollaborators < ActiveRecord::Migration[5.1]
  def change
    create_table :collaborators do |t|
      t.belongs_to :user, index: true
      t.belongs_to :wiki, index: true
      t.timestamps
    end
  end
end
