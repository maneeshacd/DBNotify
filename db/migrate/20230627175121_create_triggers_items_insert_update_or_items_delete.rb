# This migration was auto-generated via `rake db:generate_trigger_migration'.
# While you can edit this file, any changes you make to the definitions here
# will be undone by the next auto-generated trigger migration.

class CreateTriggersItemsInsertUpdateOrItemsDelete < ActiveRecord::Migration[7.0]
  def up
    create_trigger("items_after_insert_update_row_tr", :generated => true, :compatibility => 1).
        on("items").
        after(:insert, :update) do
      <<-SQL_ACTIONS
      PERFORM pg_notify('change_record', '{klass_name: items, crud_method: create_or_update, record_id: ' || COALESCE(NEW.id, 0) || '}');
      RETURN NEW;
      SQL_ACTIONS
    end

    create_trigger("items_after_delete_row_tr", :generated => true, :compatibility => 1).
        on("items").
        after(:delete) do
      <<-SQL_ACTIONS
      PERFORM pg_notify('change_record', '{klass_name: items, crud_method: delete, record_id: ' || COALESCE(OLD.id, 0) || '}');
      RETURN OLD;
      SQL_ACTIONS
    end
  end

  def down
    drop_trigger("items_after_insert_update_row_tr", "items", :generated => true)

    drop_trigger("items_after_delete_row_tr", "items", :generated => true)
  end
end
