# == Schema Information
#
# Table name: types
#
#  id         :integer          not null, primary key
#  typename   :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  color      :string
#

class Type < ApplicationRecord
	has_many :expenses

	validates :typename, :color, presence: true
end
