# == Schema Information
#
# Table name: categories
#
#  id         :integer          not null, primary key
#  catname    :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
	test "should not save category without name" do
		category = Category.new
		assert_not category.save, "Saved the category without a name"
	end
end
