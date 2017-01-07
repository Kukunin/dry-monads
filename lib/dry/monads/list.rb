require 'dry/equalizer'

module Dry
  module Monads
    class List
      def self.[](*values)
        new(values)
      end

      def self.coerce(value)
        case value
        when nil
          List.new([])
        when List
          value
        when Array
          List.new(value)
        else
          raise ArgumentError, "Can't coerce #{value.inspect} to List"
        end
      end

      include Dry::Equalizer(:value)

      attr_reader :value

      def initialize(value)
        @value = value
      end

      def bind(*args)
        if block_given?
          List.coerce(value.map { |v| yield(v, *args) }.reduce(:+))
        else
          obj, *rest = args
          List.coerce(value.map { |v| obj.call(v, *rest) }.reduce(:+))
        end
      end

      def fmap(*args)
        if block_given?
          List.new(value.map { |v| yield(v, *args) })
        else
          obj, *rest = args
          List.new(value.map { |v| obj.call(v, *rest) })
        end
      end

      def +(other)
        List.new(value + other.value)
      end

      def foldl(acc, &block)
        value.reduce(acc, &block)
      end
      alias_method :reduce, :foldl
      alias_method :inject, :foldl

      def foldr(acc)
        value.reverse.reduce(acc) { |a, b| yield(b, a) }
      end

      def inspect
        "List#{ value.to_s }"
      end
      alias_method :to_s, :inspect

      module Mixin
        List = List
        L = List

        def List(value)
          List.coerce(value)
        end
      end
    end
  end
end
