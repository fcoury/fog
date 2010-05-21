module Fog
  module Parsers
    module Webbynode

      class GetWebbies < Fog::Parsers::Base

        def reset
          @webby = {}
          @response = { 'webbies' => [] }
        end

        def end_element(name)
          case name
          when 'image-id'
            @webby[name] = @value.to_i
          when 'ip', 'name', 'status', 'notes'
            @webby[name] = @value
          when 'webby'
            @response['webbies'] << @webby
            @webby = {}
          end
        end

      end

    end
  end
end
