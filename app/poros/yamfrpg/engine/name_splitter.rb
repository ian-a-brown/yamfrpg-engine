# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Class to split a name into its consituent parts.
    class NameSplitter
      attr_reader :name, :style, :given_name, :middle_name, :surname, :suffix

      # rubocop: disable Layout/LineLength
      NAME_REGEX = /((((([[:alpha:]]+)(\s)([[:alpha:]]+\.))(,\s))|(([[:alpha:]]+\.{0,1})(,\s))|(([[:alpha:]]+\.{0,1})(\s))){0,1}(([[:alpha:]]+\.{0,1})(\s)){0,1}(([[:alpha:]]+)(\s)){0,1}){0,1}([[:alpha:]]+\.{0,1})$/
      # rubocop: enable Layout/LineLength

      def initialize(name, style = :given_name_first)
        raise 'A name is required' unless name.present?

        @name = name
        @style = style

        split_name
      end

      private

      def determine_name_parts_given_name_first(split_parts)
        if split_parts[1].include?(', ')
          given_name_first_starts_with_surname(split_parts)
          return
        end

        given_name_first_starts_with_given_name(split_parts)
      end

      # rubocop: disable Metrics/MethodLength
      def determine_name_parts_surname_first(split_parts)
        @surname = split_parts[4]
        case split_parts.length
        when 7
          @given_name = split_parts[6]
        when 10
          if split_parts[1].end_with?('. ')
            @given_name = split_parts[9]
            @suffix = split_parts[7]
            return
          end
          @given_name = split_parts[7]
          @middle_name = split_parts[9]
        when 13
          @given_name = split_parts[10]
          @middle_name = split_parts[12]
          @suffix = split_parts[7]
        end
      end
      # rubocop: enable Metrics/MethodLength

      # rubocop: disable Metrics/MethodLength
      def given_name_first_starts_with_given_name(split_parts)
        @given_name = split_parts[3]
        case split_parts.length
        when 7
          @surnamw = split_parts[6]
        when 10
          if split_parts[9].end_with?('.')
            @surname = split_parts[7]
            @suffix = split_parts[9]
            return
          end
          @middle_name = split_parts[7]
          @surname = split_parts[9]
        when 13
          @middle_name = split_parts[7]
          @surname = split_parts[10]
          @suffix = split_parts[12]
        end
      end
      # rubocop: enable Metrics/MethodLength

      # rubocop: disable Metrics/AbcSize
      # rubocop: disable Metrics/MethodLength
      def given_name_first_starts_with_surname(split_parts)
        case split_parts.length
        when 7
          @surname = split_parts[4]
          @given_name = split_parts[6]
        when 10
          if split_parts[4].end_with?('.')
            @surname = split_parts[5]
            @given_name = split_parts[9]
            @suffix = split_parts[7]
            return
          end
          @surname = split_parts[4]
          @given_name = split_parts[7]
          @middle_name = split_parts[9]
        when 13
          @surname = split_parts[5]
          @suffix = split_parts[7]
          @given_name = split_parts[10]
          @middle_name = split_parts[12]
        end
      end
      # rubocop: enable Metrics/MethodLength
      # rubocop: enable Metrics/AbcSize

      def split_name
        split_parts = name.split(NAME_REGEX)

        # If only one name is provided, always assume it is a surname.
        @surname = split_parts[2] and return if split_parts.length == 3

        case style
        when :given_name_first
          determine_name_parts_given_name_first(split_parts)
        when :surname_first
          determine_name_parts_surname_first(split_parts)
        end
      end
    end
  end
end
