module Fog
  module Parsers
    module Webbynode
      class GetWebby < Fog::Parsers::Base
        def initialize(webby_id)
          @webby_id = webby_id
          @webby = {}
        end

        def reset
          @webby = {}
          @response = nil
        end

        def end_element(name)
          case name
          when 'image-id'
            @webby[name] = @value.to_i
          when 'ip', 'name', 'status', 'notes'
            @webby[name] = @value
          when 'webby'
            @response = @webby if @webby['name'] == @webby_id
            @webby = {}
          end
        end

      end

    end
  end
end
