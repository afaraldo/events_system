class EventSerializer < ActiveModel::Serializer
  attributes :id, :description, :end_time, :name, :organizer, :start_time, :status
end
