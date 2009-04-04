unless Object.const_defined?(:Prawn)
  raise "prawn must be required before prawn-fast-png"
end

require 'rubygems'
require 'RMagick'

module Prawn
  module Images
    class PNG
      alias_method :prawn_fast_png_old_initialize, :initialize

      def initialize(data)
        @prawn_fast_png_data = data
        prawn_fast_png_old_initialize(data)
        @prawn_fast_png_data = nil
      end

      def unfilter_image_data
        img = Magick::Image.from_blob(@prawn_fast_png_data).first

        # get only one color value per pixel (Intensity) for grayscale+alpha images
        format = color_type == 4 ? 'I' : 'RGB'

        img_data      = img.export_pixels_to_str(0, 0, width, height, format)
        alpha_channel = img.export_pixels_to_str(0, 0, width, height, 'A')

        @img_data      = Zlib::Deflate.deflate(img_data)
        @alpha_channel = Zlib::Deflate.deflate(alpha_channel)
      end
    end
  end
end
