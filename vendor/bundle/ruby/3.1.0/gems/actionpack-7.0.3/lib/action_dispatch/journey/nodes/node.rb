# frozen_string_literal: true

require 'action_dispatch/journey/visitors'

module ActionDispatch
  module Journey # :nodoc:
    class Ast # :nodoc:
      attr_reader :names, :path_params, :tree, :wildcard_options, :terminals
      alias root tree

      def initialize(tree, formatted)
        @tree = tree
        @path_params = []
        @names = []
        @symbols = []
        @stars = []
        @terminals = []
        @wildcard_options = {}

        visit_tree(formatted)
      end

      def requirements=(requirements)
        # inject any regexp requirements for `star` nodes so they can be
        # determined nullable, which requires knowing if the regex accepts an
        # empty string.
        (symbols + stars).each do |node|
          re = requirements[node.to_sym]
          node.regexp = re if re
        end
      end

      def route=(route)
        terminals.each { |n| n.memo = route }
      end

      def glob?
        stars.any?
      end

      private

      attr_reader :symbols, :stars

      def visit_tree(formatted)
        tree.each do |node|
          if node.symbol?
            path_params << node.to_sym
            names << node.name
            symbols << node
          elsif node.star?
            stars << node

            if formatted != false
              # Add a constraint for wildcard route to make it non-greedy and
              # match the optional format part of the route by default.
              wildcard_options[node.name.to_sym] ||= /.+?/m
            end
          end

          terminals << node if node.terminal?
        end
      end
    end

    module Nodes # :nodoc:
      class Node # :nodoc:
        include Enumerable

        attr_accessor :left, :memo

        def initialize(left)
          @left = left
          @memo = nil
        end

        def each(&block)
          Visitors::Each::INSTANCE.accept(self, block)
        end

        def to_s
          Visitors::String::INSTANCE.accept(self, '')
        end

        def to_dot
          Visitors::Dot::INSTANCE.accept(self)
        end

        def to_sym
          name.to_sym
        end

        def name
          -left.tr('*:', '')
        end

        def type
          raise NotImplementedError
        end

        def symbol?() = false
        def literal?() = false
        def terminal?() = false
        def star?() = false
        def cat?() = false
        def group?() = false
      end

      class Terminal < Node # :nodoc:
        alias symbol left
        def terminal?() = true
      end

      class Literal < Terminal # :nodoc:
        def literal?() = true
        def type() = :LITERAL
      end

      class Dummy < Literal # :nodoc:
        def initialize(x = Object.new)
          super
        end

        def literal?() = false
      end

      class Slash < Terminal # :nodoc:
        def type() = :SLASH
      end

      class Dot < Terminal # :nodoc:
        def type() = :DOT
      end

      class Symbol < Terminal # :nodoc:
        attr_accessor :regexp
        alias symbol regexp
        attr_reader :name

        DEFAULT_EXP = %r{[^./?]+}
        GREEDY_EXP = /(.+)/
        def initialize(left, regexp = DEFAULT_EXP)
          super(left)
          @regexp = regexp
          @name = -left.tr('*:', '')
        end

        def type() = :SYMBOL
        def symbol?() = true
      end

      class Unary < Node # :nodoc:
        def children() = [left]
      end

      class Group < Unary # :nodoc:
        def type() = :GROUP
        def group?() = true
      end

      class Star < Unary # :nodoc:
        attr_accessor :regexp

        def initialize(left)
          super(left)

          # By default wildcard routes are non-greedy and must match something.
          @regexp = /.+?/m
        end

        def star?() = true
        def type() = :STAR

        def name
          left.name.tr '*:', ''
        end
      end

      class Binary < Node # :nodoc:
        attr_accessor :right

        def initialize(left, right)
          super(left)
          @right = right
        end

        def children() = [left, right]
      end

      class Cat < Binary # :nodoc:
        def cat?() = true
        def type() = :CAT
      end

      class Or < Node # :nodoc:
        attr_reader :children

        def initialize(children)
          @children = children
        end

        def type() = :OR
      end
    end
  end
end
