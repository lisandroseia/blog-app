# frozen_string_literal: true

module Mail
  class Address
    def ==(other)
      other.is_a?(Mail::Address) && to_s == other.to_s
    end
  end
end
