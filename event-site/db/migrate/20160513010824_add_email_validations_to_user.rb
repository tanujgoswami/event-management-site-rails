class AddEmailValidationsToUser < ActiveRecord::Migration
  def up
    execute %{
      ALTER TABLE
        users
      ADD CONSTRAINT
        email_must_be_valid
      CHECK ( email ~* '/\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i )
    }
  end

  def down
    execute %{
      ALTER TABLE
        users
      DROP CONSTRAINT
        email_must_be_valid
    }
  end
end
