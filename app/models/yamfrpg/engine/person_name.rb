# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Model representing the name of a person in YAMFRPG.
    class PersonName < ApplicationRecord
      enum style: %i[given_name_first surname_first]

      has_one :user, class_name: Yamfrpg::Engine::User.to_s, required: false

      validates_presence_of :given_name
      validates_presence_of :surname
      validates_presence_of :style

      scope :for_name, lambda { |name, style|
        name_splitter = Yamfrpg::Engine::NameSplitter.new(name, style)
        query = PersonName.build_name_part_query(name_splitter, :surname)
        if name_splitter.given_name.present?
          query = PersonName.build_name_part_query(name_splitter, :given_name, query:)
        end
        if name_splitter.middle_name.present?
          query = PersonName.build_name_part_query(name_splitter, :middle_name, query:)
        end
        query = PersonName.build_name_part_query(name_splitter, :suffix, query:) if name_splitter.suffix.present?
        query.where(style: style.to_s)
        query
      }

      # Class methods for person name.
      class << self
        def build_name_part_query(name_splitter, part, query: nil)
          clause = "yamfrpg_engine_person_names.#{part} ILIKE :part"
          return where(clause, { part: name_splitter.send(part) }) unless query.present?

          query.where(clause, { part: name_splitter.send(part) })
        end
      end

      def legal_name
        case style
        when :given_name_first
          "#{given_name}#{middle_name_in_name} #{surname}#{suffix_in_name}"
        when :surname_first
          "#{surname}#{suffix_in_name} #{given_name}#{middle_name_in_name}"
        end
      end

      def middle_initial
        return '' unless middle_name.present?

        "#{middle_name.substring(0, 1)}."
      end

      def middle_initial_in_name
        return '' unless middle_name.present?

        " #{middle_initial}"
      end

      def middle_name_in_name
        return '' unless middle_name.present?

        " #{middle_name}"
      end

      def short_name
        case style
        when :given_name_first
          "#{given_name} #{surname}#{suffix_in_name}"
        when :last_name_first
          "#{surname}#{suffix_in_name} #{given_name}"
        end
      end

      # rubocop: disable Metrics/AbcSize
      def name
        case style.to_sym
        when :given_name_first
          "#{given_name}#{middle_name_in_name} #{surname}#{suffix_in_name}"
        when :surname_first
          "#{surname}#{suffix_in_name} #{given_name}#{middle_name_in_name}"
        else
          raise "Unrecognized style: #{style} for #{id} #{given_name} #{middle_name} #{surname} #{suffix}"
        end
      end
      # rubocop: enable Metrics/AbcSize

      def suffix_in_name
        return '' unless suffix.present?

        " #{suffix}"
      end
    end
  end
end
