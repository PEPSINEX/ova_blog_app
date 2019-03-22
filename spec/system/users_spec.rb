require 'rails_helper'

describe 'ユーザー登録機能', type: :system do
  describe '一覧表示機能' do
  let!(:user_a) { FactoryBot.create(:user, name: 'ユーザーA', email: 'a@test.com') }
  let!(:user_b) { FactoryBot.create(:user, name: 'ユーザーB', email: 'b@test.com') }
    before do
      visit users_path
    end

    context 'ユーザーが二人登録されている時' do
      it 'ユーザーAとユーザーBの名前が表示される' do
        expect(page).to have_content 'ユーザーA'
        expect(page).to have_content 'ユーザーB'
      end
    end
  end
end