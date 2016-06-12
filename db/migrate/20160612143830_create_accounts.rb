class CreateAccounts < ActiveRecord::Migration
  def up
    create_table :accounts, id: false do |t|
      t.string :token, null: false, uniq: true
      t.json :_wallet, default: {}, null: true
      t.timestamps null: false
    end
    execute 'ALTER TABLE "accounts" ADD PRIMARY KEY ("token");'
  end

  def down
    drop_table :accounts
  end
end
