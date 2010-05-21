module Fog
  module Parsers
    module Webbynode

      class GetImage < Fog::Parsers::Base
        def initialize(image_id)
          @image_id = image_id
          @image = {}
        end

        def reset
          @image = {}
          @response = nil
        end

        def end_element(name)
          case name
          when 'id'
            @image[name] = @value.to_i
          when 'image'
            @response = @image if @image['id'] == @image_id
            @image = {}
          when 'name'
            @image[name] = @value
          end
        end

      end

    end
  end
end
