module Fog
  module Parsers
    module Webbynode

      class CreateWebby < Fog::Parsers::Base

        def reset
          @response = {}
        end

        def end_element(name)
          case name
          when 'ip'
            @response['ip'] = @value
          when 'image-id'
            @response[name] = @value.to_i
          when 'name', 'status'
            @response[name] = @value
          end
        end

      end

    end
  end
end
