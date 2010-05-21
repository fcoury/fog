module Fog
  module Webbynode
    class Real

      require 'fog/webbynode/parsers/get_webby'

      # Get details of a Webby
      #
      # ==== Parameters
      # * webby_id<~Integer> - Id of Webby to lookup
      #
      # ==== Returns
      # * response<~Excon::Response>:
      #   * body<~Array>:
      #     * 'plan'<~String> - Plan
      #     * 'status'<~String> - Current status of the Webby
      #     * 'ip'<~String> - Ip addresses for the Webby
      #     * 'name'<~String> - Name of the Webby
      #     * 'notes'<~String> - Notes for the Webby
      #     * 'image-id'<~Integer> - Id of image Webby was booted from
      def get_webby(webby_id)
        request(
          :expects  => 200,
          :method   => 'GET',
          :parser   => Fog::Parsers::Webbynode::GetWebby.new,
          :path     => "/webbies/#{webby_id}"
        )
      end

    end

    class Mock

      def get_webby(id)
        raise MockNotImplemented.new("Contributions welcome!")
      end

    end
  end
end
