class Card < ActiveRecord::Base
  has_many :leads, dependent: :destroy
end
