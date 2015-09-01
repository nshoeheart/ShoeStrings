require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

    def setup
        @user = User.new(username: "example", email: "user@example.com", password: "foobar", password_confirmation: "foobar")
    end

    test "should be valid" do
        assert @user.valid?
    end

    # username tests
    test "username should be present" do
        @user.username = "     "
        assert_not @user.valid?
    end

    test "username should not be too long" do
        @user.username = "a" * 51
        assert_not @user.valid?
    end

    test "username validation should accept valid usernames" do
        valid_usernames = %w[a abc123 a_bc123 ab-C123 a.bcd123 A-b.c_123 a1b-1.23C_4a]
        valid_usernames.each do |valid_username|
            @user.username = valid_username
            assert @user.valid?, "#{valid_username.inspect} should be valid"
        end
    end

    test "username validation should reject invalid usernames" do
        invalid_usernames = %w[1 - . _ ! a! A..123 A__123 A--123 A-!abc e-__-3]
        invalid_usernames.each do |invalid_username|
            @user.username = invalid_username
            assert_not @user.valid?, "#{invalid_username.inspect} should be invalid"
        end
    end


    # email tests
    test "email should be present" do
        @user.email = "     "
        assert_not @user.valid?
    end

    test "email should not be too long" do
        @user.email = "a" * 244 + "@example.com"
        assert_not @user.valid?
    end

    test "email validation should accept valid addresses" do
        valid_addresses = %w[user@example.com USER@foo.com A_US-ER@foo.bar.org first.last@foo.jp alice+bob@baz.cn]
        valid_addresses.each do |valid_address|
            @user.email = valid_address
            assert @user.valid?, "#{valid_address.inspect} should be valid"
        end
    end

    test "email validation should reject invalid addresses" do
        invalid_addresses = %w[user@example,com user_at_foo.org user.name@example. foo@bar_baz.com foo@bar+baz.com]
        invalid_addresses.each do |invalid_address|
            @user.email = invalid_address
            assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
        end
    end

    test "email addresses should be unique" do
        duplicate_user = @user.dup
        duplicate_user.email = @user.email.upcase
        @user.save
        assert_not duplicate_user.valid?
    end


    # password tests
    test "password should be present (nonblank)" do
        @user.password = @user.password_confirmation = " " * 6
        assert_not @user.valid?
    end

    test "password should have a minimum length" do
        @user.password = "a" * 5
        assert_not @user.valid?
    end
end
