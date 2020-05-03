module VirtualNameCard
  class Image
    attr_reader :mini_magick_image

    def initialize(mini_magick_image:)
      @mini_magick_image = mini_magick_image
    end
  end
end
