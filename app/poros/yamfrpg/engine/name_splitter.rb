# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Class to split a name into its consituent parts.
    class NameSplitter
      attr_reader :name, :style, :given_name, :middle_name, :surname, :suffix, :matcher

      SEP = '(?=\s|,|$)'
      NAME_SUB = "([[:alpha:]]|'|-)+#{SEP}".freeze
      SUFFIX_SUB = "(Sr|SR|Sr.|SR.|Jr|JR|Jr.|JR.|Ret.|RET.|JD|PhD|DDS|[CDILMOVX]+)#{SEP}".freeze
      GIVEN = "(?<given>#{NAME_SUB})".freeze
      MIDDLE = "(?<middle>#{NAME_SUB})".freeze
      SURNAME = "(?<surname>#{NAME_SUB})".freeze
      SUFFIX = "(?<suffix>#{SUFFIX_SUB})".freeze
      SPACES = '\\s+'
      COMMA = ',\\s*'

      SURNAME_ONLY = "^#{SURNAME}$".freeze

      # Given name first.
      GIVEN_SURNAME = "(?<given_surname>#{GIVEN}#{SPACES}#{SURNAME})".freeze
      SURNAME_COMMA_GIVEN = "(?<surname_comma_given>#{SURNAME}#{COMMA}#{GIVEN})".freeze
      GIVEN_MIDDLE_SURNAME = "(?<given_middle_surname>#{GIVEN}#{SPACES}#{MIDDLE}#{SPACES}#{SURNAME})".freeze
      GIVEN_SURNAME_SUFFIX = "(?<given_surname_suffix>#{GIVEN}#{SPACES}#{SURNAME}#{SPACES}#{SUFFIX})".freeze
      SURNAME_SUFFIX_COMMA_GIVEN = "(?<surname_suffix_comma_given>#{SURNAME}#{SPACES}#{SUFFIX}#{COMMA}#{GIVEN})".freeze
      SURNAME_COMMA_GIVEN_MIDDLE = "(?<surname_comma_given_middle>#{SURNAME}#{COMMA}#{GIVEN}#{SPACES}#{MIDDLE})".freeze
      GIVEN_MIDDLE_SURNAME_SUFFIX =
        "(?<given_middle_surname_suffix>#{GIVEN}#{SPACES}#{MIDDLE}#{SPACES}(#{SURNAME})#{SPACES}#{SUFFIX})".freeze
      SURNAME_SUFFIX_COMMA_GIVEN_MIDDLE =
        "(?<surname_suffix_comma_given_middle>#{SURNAME}#{SPACES}#{SUFFIX}#{COMMA}#{GIVEN}#{SPACES}#{MIDDLE})".freeze
      GIVEN_NAME_FIRST_MATCHERS = [
        SURNAME_SUFFIX_COMMA_GIVEN_MIDDLE,
        GIVEN_MIDDLE_SURNAME_SUFFIX,
        SURNAME_COMMA_GIVEN_MIDDLE,
        SURNAME_SUFFIX_COMMA_GIVEN,
        GIVEN_SURNAME_SUFFIX,
        GIVEN_MIDDLE_SURNAME,
        SURNAME_COMMA_GIVEN,
        GIVEN_SURNAME,
        SURNAME_ONLY
      ].freeze

      # Surname first.
      SURNAME_GIVEN = "(?<surname_given>#{SURNAME}#{SPACES}#{GIVEN})".freeze
      SURNAME_GIVEN_MIDDLE = "(?<surname_given_middle>#{SURNAME})#{SPACES}#{GIVEN}#{SPACES}(#{MIDDLE})".freeze
      SURNAME_SUFFIX_GIVEN = "(?<surname_suffix_given>#{SURNAME}#{SPACES}#{SUFFIX}#{SPACES}#{GIVEN})".freeze
      SURNAME_SUFFIX_GIVEN_MIDDLE =
        "(?<surname_suffix_given_middle>#{SURNAME}#{SPACES}#{SUFFIX}#{SPACES}#{GIVEN}#{SPACES}#{MIDDLE})".freeze
      SURNAME_FIRST_MATCHERS = [
        SURNAME_SUFFIX_GIVEN_MIDDLE,
        SURNAME_SUFFIX_GIVEN,
        SURNAME_GIVEN_MIDDLE,
        SURNAME_GIVEN,
        SURNAME_ONLY
      ].freeze

      def initialize(name, style = :given_name_first)
        raise 'A name is required' unless name.present?

        @name = name
        @style = style

        split_name
      end

      private

      def choose_matchers
        case style
        when :given_name_first
          GIVEN_NAME_FIRST_MATCHERS
        when :surname_first
          SURNAME_FIRST_MATCHERS
        end
      end

      def match_name
        matchers = choose_matchers
        nil unless matchers.present?

        try_matchers(matchers)
      end

      def split_name
        matcher, parts = match_name
        return unless matcher.present?

        captures = parts.named_captures
        @given_name = captures['given']
        @middle_name = captures['middle']
        @surname = captures['surname']
        @suffix = captures['suffix']
        @matcher = matcher
      end

      def try_matchers(matchers)
        matchers.each do |matcher|
          parts = /#{matcher}/.match(@name)
          next unless parts.present?

          return [matcher, parts]
        end
        [nil, nil]
      end
    end
  end
end
