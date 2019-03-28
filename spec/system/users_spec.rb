require 'rails_helper'

describe 'ユーザー管理機能', type: :system do
  describe '新規登録機能' do
    let(:user_correct) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@test.com', password: 'password', password_confirmation: 'password') }
    let(:user_incorrect) { FactoryBot.create(:user, name: '失敗A', email: 'test.com', password: 'notpass', password_confirmation: 'password') }

    before do
      visit new_user_path
    end

    context '入力した値が正しいとき' do
      before do
        fill_in '名前', with: 'ユーザーA'
        fill_in 'メールアドレス', with: 'a@test.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード再入力', with: 'password'
        click_button '登録する'
      end

      it '登録したユーザーの詳細画面が表示される' do
        expect(page).to have_content "#{User.model_name.human}登録をしました", 'ユーザーA'
      end
    end

    context '入力した値が間違っているとき' do
      before do
        fill_in '名前', with: '失敗B'
        fill_in 'メールアドレス', with: 'b@test.com'
        fill_in 'パスワード', with: 'password'
        fill_in 'パスワード再入力', with: 'password'
        click_button '登録する'
      end

      it '登録したユーザーの詳細画面が表示される' do
        expect(page).to have_content 'ユーザー登録'
      end
    end
  end
end