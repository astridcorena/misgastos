# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  catname    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Category < ApplicationRecord
	has_many :expenses

	validates :catname, presence: true
end
