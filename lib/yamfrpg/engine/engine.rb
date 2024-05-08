# frozen_string_literal: true

module Yamfrpg
  module Engine
    # Rails engine class for YAMFRPG.
    class Engine < ::Rails::Engine
      isolate_namespace Yamfrpg::Engine
    end
  end
end
