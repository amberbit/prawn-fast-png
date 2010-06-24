# Monkey-patches RGB and A separation code in Prawn::Images::PNG class.

require 'prawn/images/png_patch'

module Prawn
  module FastPng
    VERSION = '0.2.3'
  end
end
