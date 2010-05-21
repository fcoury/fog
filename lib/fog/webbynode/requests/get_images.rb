module Fog
  module Webbynode
    class Real

      require 'fog/webbynode/parsers/get_images'

      # Get list of images
      #
      # ==== Returns
      # * response<~Excon::Response>:
      #   * body<~Array>:
      #     * 'id'<~Integer> - Id of the image
      #     * 'name'<~String> - Name of the image
      #     * 'image'<~String> - Image identifier
      def get_images
        request(
          :expects  => 200,
          :method   => 'POST',
          :parser   => Fog::Parsers::Webbynode::GetImages.new,
          :path     => 'images'
        )
      end
    end

    class Mock

      def get_images
        raise MockNotImplemented.new("Contributions welcome!")
      end

    end
  end
end
