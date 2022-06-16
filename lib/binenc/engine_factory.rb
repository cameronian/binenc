

module Binenc
  class EngineFactory

    def self.instance(*args, &block)
      Provider.instance.provider.engine_instance(*args, &block)
    end
  end
end
