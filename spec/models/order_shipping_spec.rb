require 'rails_helper'

RSpec.describe OrderShipping, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item)
    @order_shipping = FactoryBot.build(:order_shipping, user_id: @user.id, item_id: @item.id)
  end
  describe '購入情報の保存' do
    context '購入できるとき' do
      it '全ての項目が正しく入力されていれば保存できる' do
        expect(@order_shipping).to be_valid
      end
      it '都道府県が「---」以外なら保存できる' do
        @order_shipping.prefecture_id = 2
        expect(@order_shipping).to be_valid
      end
      it '市区町村が入力されていれば保存できる' do
        @order_shipping.city = '渋谷区'
        expect(@order_shipping).to be_valid
      end
      it '番地が入力されていれば保存できる' do
        @order_shipping.address = '1-1-1'
        expect(@order_shipping).to be_valid
      end
      it '建物名が空でも保存できる' do
        @order_shipping.building = ''
        expect(@order_shipping).to be_valid
      end
      it '電話番号が10桁の半角数字なら保存できる' do
        @order_shipping.phone_number = '0312345678'
        expect(@order_shipping).to be_valid
      end
      it '電話番号が11桁の半角数字なら保存できる' do
        @order_shipping.phone_number = '09012345678'
        expect(@order_shipping).to be_valid
      end
    end
    context '購入できないとき' do
      it '郵便番号が空では保存できない' do
        @order_shipping.postal_code = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Postal code can't be blank")
      end
      it '郵便番号がハイフンなしでは保存できない' do
        @order_shipping.postal_code = '1234567'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Postal code is invalid')
      end
      it '都道府県が未選択「---」では保存できない' do
        @order_shipping.prefecture_id = 1
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Prefecture must be other than 1')
      end
      it '市区町村が空では保存できない' do
        @order_shipping.city = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("City can't be blank")
      end
      it '番地が空では保存できない' do
        @order_shipping.address = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Address can't be blank")
      end
      it '電話番号が空では保存できない' do
        @order_shipping.phone_number = ''
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Phone number can't be blank")
      end
      it '電話番号が9桁以下では保存できない' do
        @order_shipping.phone_number = '090123456'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号が12桁以上では保存できない' do
        @order_shipping.phone_number = '090123456789'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号にハイフンが含まれていると保存できない' do
        @order_shipping.phone_number = '090-1234-5678'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid')
      end
      it '電話番号に半角数字以外が含まれていると保存できない' do
        @order_shipping.phone_number = '０９０１２３４５６７８'
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include('Phone number is invalid')
      end
      it 'user_idが空では保存できない' do
        @order_shipping.user_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("User can't be blank")
      end

      it 'item_idが空では保存できない' do
        @order_shipping.item_id = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Item can't be blank")
      end

      it 'tokenが空では保存できない' do
        @order_shipping.token = nil
        @order_shipping.valid?
        expect(@order_shipping.errors.full_messages).to include("Token can't be blank")
      end
    end
  end
end
