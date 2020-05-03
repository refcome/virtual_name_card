module VirtualNameCard
  class Image
    attr_reader :mini_magic_image

    def initialize(mini_magic_image:)
      @mini_magic_image = mini_magic_image
    end
  end
end
