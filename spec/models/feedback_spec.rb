require 'rails_helper'

RSpec.describe Feedback, type: :model do
  it { should validate_presence_of :email }
  it { should validate_presence_of :text }
end
