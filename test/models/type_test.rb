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

require 'test_helper'

class TypeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  	test "should not save type without name" do
		type = Type.new
		assert_not type.save, "Saved the type without a name"
	end
end
