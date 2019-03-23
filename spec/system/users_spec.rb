require 'rails_helper'

describe 'ユーザー登録機能', type: :system do
  describe '新規登録機能' do
  let!(:user_sucess) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@test.com', password: 'password', password_confirmation: 'password') }
  let!(:user_mail_failue) { FactoryBot.create(:user, name: 'ユーザーB', email: 'test.com', password: 'password', password_confirmation: 'password') }
    before do
      visit new_users_path
    end

    context 'ユーザーが二人登録されている時' do
      it 'ユーザーAとユーザーBの名前が表示される' do
        expect(page).to have_content 'ユーザーA'
        expect(page).to have_content 'ユーザーB'
      end
    end
  end
end