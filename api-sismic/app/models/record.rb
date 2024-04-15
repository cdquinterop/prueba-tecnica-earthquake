class Record < ApplicationRecord
    has_many :comments, dependent: :destroy
end
