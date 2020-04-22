# frozen_string_literal: true

require 'mini_magick'

class Builder
  BASE_IMAGE_PATH = './base_image.png'
  TEXT_POSITION = '0,0'
  FONT_SIZE = 65
  INDENTION_COUNT = 11
  ROW_LIMIT = 8
  GENERATED_FILE_PATH = "./generated_file.png"
  FONT_FILE_PATH = "./NotoSansJP-Medium.otf"

  class << self
    def write(name_kanji:, name_romaji:, role:, twitter_account:)
      @image = MiniMagick::Image.open(BASE_IMAGE_PATH)

      name_kanji_combine(name_kanji)
      name_romaji_combine(name_romaji)
      role_combine(role)
      twitter_account_combine(twitter_account)

      @image.write GENERATED_FILE_PATH
    end

    private def name_kanji_combine(text)
      @image.combine_options do |config|
        config.font "./NotoSansJP-Medium.otf"
        config.gravity "west"
        config.pointsize 80
        config.draw "text 90,-90 '#{text}'"
      end
    end

    private def name_romaji_combine(text)
      @image.combine_options do |config|
        config.font "./NotoSansJP-Regular.otf"
        config.gravity "west"
        config.pointsize 40
        config.draw "text 90,0 '#{text}'"
      end
    end

    private def role_combine(text)
      @image.combine_options do |config|
        config.font "./NotoSansJP-Regular.otf"
        config.gravity "west"
        config.pointsize 40
        config.draw "text 90,70 '#{text}'"
      end
    end

    private def twitter_account_combine(text)
      @image.combine_options do |config|
        config.font "./NotoSansJP-Regular.otf"
        config.gravity "west"
        config.pointsize 40
        config.draw "text 90,400 '#{text}'"
      end
    end
  end
end

Builder.write(name_kanji: ARGV[0], name_romaji: ARGV[1], role: ARGV[2], twitter_account: ARGV[3])