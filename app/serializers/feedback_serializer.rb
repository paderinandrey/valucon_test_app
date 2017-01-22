class FeedbackSerializer < ActiveModel::Serializer
  attributes :id, :email, :text
end
