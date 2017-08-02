require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @subject = User.new
  end

  should validate_presence_of(:email)
  should validate_presence_of(:password)
  
  test "email should be a valid email" do
    @subject.email = "invalid"
    @subject.valid?
    
    assert_includes(@subject.errors[:email], "is not an email")
  end
  
  test "email should be unique" do
    create(:user, email: "email@domain.com")
    
    @subject.email = "email@domain.com"
    @subject.valid?
    
    assert_includes(@subject.errors[:email], "has already been taken")
  end
  
  test "phone should be a valid phone" do
    @subject.phone = "invalid"
    @subject.valid?
    
    assert_includes(@subject.errors[:phone], "is not a phone")
  end
end