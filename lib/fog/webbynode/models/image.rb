require 'fog/model'

module Fog
  module Webbynode

    class Image < Fog::Model

      identity :id

      attribute :name

    end

  end
end
