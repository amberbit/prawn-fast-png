# Extracts the data from a PNG that is needed for embedding. Uses RMagick to
# separate RGB and A channels.

require 'prawn'
require 'RMagick'

module Prawn
  module Images
    class PNG
      alias_method :prawn_fast_png_old_initialize, :initialize

      def initialize(data) #:nodoc:
        @prawn_fast_png_data = data
        prawn_fast_png_old_initialize(data)
      end

      private

      def unfilter_image_data
        img = Magick::Image.from_blob(@prawn_fast_png_data).first

        # get only one color value per pixel (Intensity) for grayscale+alpha images
        format = color_type == 4 ? 'I' : 'RGB'

        img_data      = img.export_pixels_to_str(0, 0, width, height, format)
        alpha_channel = img.export_pixels_to_str(0, 0, width, height, 'A')

        @img_data      = Zlib::Deflate.deflate(img_data)
        @alpha_channel = Zlib::Deflate.deflate(alpha_channel)

        # image blob not needed anymore, let GC take care of it
        @prawn_fast_png_data = nil
      end
    end
  end
end

