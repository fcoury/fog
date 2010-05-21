module Fog
  module Webbynode
    class Real

      require 'fog/webbynode/parsers/get_image'

      # Get details of an image
      #
      # ==== Parameters
      # * image_id<~Integer> - Id of image to lookup
      #
      # ==== Returns
      # * response<~Excon::Response>:
      #   * body<~Array>:
      #     * 'id'<~Integer> - Id of the image
      #     * 'name'<~String> - Name of the image
      def get_image(image_id)
        response = request(
          :expects  => 200,
          :method   => 'POST',
          :parser   => Fog::Parsers::Webbynode::GetImage.new(image_id),
          :path     => "images"
        )
        
        # image = response.body['images'].select { |i| i["id"] == image_id }
        # response.body.delete('image')
        # response.body['image'] = image.first if image.any?
        # 
        # pp response
        
        response
      end

    end

    class Mock

      def get_image(image_id)
        raise MockNotImplemented.new("Contributions welcome!")
      end

    end
  end
end
