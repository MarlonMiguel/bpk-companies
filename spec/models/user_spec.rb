require 'rails_helper'

RSpec.describe User, type: :model do
  subject { described_class.new(email: "jondoe@gmail.com", password: "password", role: "admin", name: "John Doe", phone: "123456789") }

  describe "validations" do
    it "is valid with valid attributes" do
      expect(subject).to be_valid
    end

    it "is not valid without an email" do
      subject.email = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a password" do
      subject.password = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a role" do
      subject.role = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a name" do
      subject.name = nil
      expect(subject).to_not be_valid
    end

    it "is not valid without a phone" do
      subject.phone = nil
      expect(subject).to_not be_valid
    end
  end

  # Testar Métodos
  describe "#admin?" do
    it "returns true if role is admin" do
      subject.role = "admin"
      expect(subject.admin?).to be_truthy
    end

    it "returns false if role is not admin" do
      subject.role = "vendedor"
      expect(subject.admin?).to be_falsey
    end
  end
end
