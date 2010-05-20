
module JavaClassLoader

  # Include java classes described in :klasses_hash into :base_module.
  #
  def JavaClassLoader.include_java_classes(base_module, klasses_hash)
    klasses_hash.each_pair do |package_name, klasses|
      klasses.each do |klass_name|
        if klass_name.is_a? Hash
          base_module.include_class([package_name, klass_name.keys.first].join('.')) { klass_name.values.first }
        elsif klass_name.is_a? String
          base_module.include_class "#{package_name}.#{klass_name}"
        end
      end
    end
  end

end