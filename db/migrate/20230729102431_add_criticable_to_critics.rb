class AddCriticableToCritics < ActiveRecord::Migration[7.0]
  def change
    add_reference :critics, :criticable, polymorphic: true
  end
end
