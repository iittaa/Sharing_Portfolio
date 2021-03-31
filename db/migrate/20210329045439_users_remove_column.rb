class UsersRemoveColumn < ActiveRecord::Migration[6.0]
  def change
    # remove_columns :テーブル名, :カラム名, :カラム名,  :カラム名
    remove_columns :users, :password_digest, :remember_digest, :reset_digest, :reset_sent_at
  end
end
