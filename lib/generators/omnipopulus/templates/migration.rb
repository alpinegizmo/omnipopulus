class CreateOmnipopulusTables < ActiveRecord::Migration
  def self.up
    unless table_exists? :users
      create_table :users do |t|
        t.string :remember_token
        # Any additional fields here

        t.timestamps
      end
    else
      add_column(:users, :remember_token, :string)  unless column_exists?(:users, :remember_token)
    end

    unless table_exists? :login_accounts
      create_table :login_accounts do |t|
        t.string :type
        t.integer :user_id
        t.string :remote_account_id
        t.string :name
        t.string :login
        t.string :picture_url
        t.string :account_url
        t.text :auth_hash
        t.string :access_token
        t.string :access_token_secret
        # Any additional fields here 

        t.timestamps
      end

      add_index :login_accounts, :type
      add_index :login_accounts, :user_id
    end

  end

  def self.down
    remove_index :login_accounts, :type
    remove_index :login_accounts, :user_id
    drop_table :login_accounts
    drop_table :users
  end
end
