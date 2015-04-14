module EplApi
  module Utils
    module_function

    def camelize(string)
      string.split('_').map.with_index { |w, i|
        w.capitalize! if i > 0
        w
      }.join()
    end

  end
end
