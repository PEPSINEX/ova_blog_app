require 'rails_helper'

describe '管理者機能', type: :system do
  let!(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@test.com') }
  let!(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@test.com') }
  let!(:disabled_user_c) { FactoryBot.create(:user, is_enabled: false, name: 'ユーザーC', email: 'c@test.com') }
  User.skip_callback(:save, :before, :set_not_admin)
  let!(:admin_user) { FactoryBot.create(:user, admin: true, name: '管理ユーザー', email: 'admin@test.com') }

  before do
    visit login_path
  end

  describe '管理と非管理者でroutingを分岐させる' do
    context '管理ユーザーでログインした時' do
      before do
        fill_in 'メールアドレス', with: 'admin@test.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it '管理画面トップに移動する' do
        expect(page).to have_content '管理画面', 'ユーザーB'
      end
    end

    context '非管理ユーザーでログインした時' do
      before do
        fill_in 'メールアドレス', with: 'b@test.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'ユーザー詳細画面に移動' do
        expect(page).to have_content 'ユーザー詳細', 'ユーザーB'
      end
    end
  end

  describe 'アカウント無効ユーザーはログインできない' do
    context 'アカウント状態が無効でログインしようとした時' do
      before do
        fill_in 'メールアドレス', with: 'c@test.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログインする'
      end

      it 'ログイン画面に戻る' do
        expect(page).to have_content 'ログイン', 'アカウントが無効です'
      end
    end
  end
end
