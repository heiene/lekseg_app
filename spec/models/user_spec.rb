# == Schema Information
#
# Table name: users
#
#  id         :integer         not null, primary key
#  name       :string(255)
#  email      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#
#
#  Før man kan kjøre tester i test database må man sørge for å reflektere development db i test:
#  "bundle exec rake db:test:prepare"
#


require 'spec_helper'

# Initierer User test.
describe User do

	# before sørger for at før man kjører testen, så gjør man det som står inne i blocken
	# her setter man opp en test user og lagrer den i instansvariablen @user
  before do
   	@user = User.new(name: "Example User", email: "user@example.com",
   										password: "foobar", password_confirmation: "foobar")
  	
  end

  # subject betyr bare at man kan droppe det inne i (@user) foran hver test, 
  # som i should istedenfor @user.should
  # "@user.respond_to?(:name)" er ruby måten å si det på
  # Rspec oversetter dette til: "@user.should respond_to(:name)""
  # men ettersom man har med "subject { @user }"  kan man skrive "it { should respond_to(:name) }"
	subject { @user }

  it { should respond_to(:name) }
  it { should respond_to(:email) }

  # for å få denn under til å passe må man vist: 

  # rails generate migration add_password_digest_to_users password_digest:string
  
  # det er bare er fordi vi "glemte" å legge det til modellen in the first place.
  # Here the first argument is the migration name, 
  # and we’ve also supplied a second argument with the name 
  # and type of attribute we want to create. (Compare this to the original 
	# generation of the users table in Listing 6.1.) We can choose any migration name we want, 
	# but it’s convenient to end the name with _to_users, since in this case Rails automatically
 	# constructs a migration to add columns to the users table.
  it { should respond_to(:password_digest) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }
  it { should respond_to(:authenticate) }


  # bare sjekker at user name er valid
  it { should be_valid }

  # her sjekker man at user name ikke kan være tomt
  describe "when missing name" do
  	before { @user.name = " " }
  	it { should_not be_valid }
  end

	# her sjekker man at user email ikke kan være tomt
  describe "when missing email" do
  	before { @user.email = " " }
  	it { should_not be_valid }
  end
  # Name kan ikke være over 50 karakterer
  describe "when name is too long" do
    before { @user.name = "a" * 51 }
    it { should_not be_valid }
  end

  describe "when email format is invalid" do
    it "should be invalid" do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end      
    end
  end

  describe "when email format is valid" do
    it "should be valid" do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end      
    end
  end

   describe "when email address is already taken" do
    before do
      user_with_same_email = @user.dup
      user_with_same_email.email = @user.email.upcase #tester at man ikke kan ha en versjon av store bokstaver av mailadresse
      user_with_same_email.save
    end

    it { should_not be_valid }
  end

 	#Password
 	describe "when password is not present" do
    before { @user.password = @user.password_confirmation = " " }
    it { should_not be_valid }
  end

  describe "when password doesn't match confirmation" do
    before { @user.password_confirmation = "mismatch" }
    it { should_not be_valid }
  end

  describe "when password confirmation is nil" do
    before { @user.password_confirmation = nil }
    it { should_not be_valid }
  end

  describe "with a password that's too short" do
    before { @user.password = @user.password_confirmation = "a" * 5 }
    it { should be_invalid }
  end

  describe "return value of authenticate method" do
    before { @user.save }
    let(:found_user) { User.find_by_email(@user.email) }

    describe "with valid password" do
      it { should == found_user.authenticate(@user.password) }
    end

    describe "with invalid password" do
      let(:user_for_invalid_password) { found_user.authenticate("invalid") }

      it { should_not == user_for_invalid_password }
      specify { user_for_invalid_password.should be_false }
    end
  end

end