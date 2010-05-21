module Fog
  module Parsers
    module Webbynode

      class GetJob < Fog::Parsers::Base

        def reset
          @response = {}
        end

        def end_element(name)
          case name
          when 'job-id'
            @response['id'] = @value.to_i
          end
        end

      end

    end
  end
end
