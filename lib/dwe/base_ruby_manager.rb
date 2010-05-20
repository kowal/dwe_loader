
module Dwe

  # SimpleRailsManger class defines the loading process for STDW engine
  # for Ruby applications
  #
  class BaseRubyManager < Dwe::SimpleManager
    
    def startApplication      
      unless initialized?
        raise "application not initialized"
      end

      if closed?
        raise "application closed"
      end

      engine = Dwe::ConfigFactory.getInstance.getEngineSection.getEngine
      layout = Dwe::ConfigFactory.getInstance.getLayoutSection.getLayout
        
      engine.setManager(self)
      engine.setUserInterface(layout)
        
      layout.setManager(self);
      layout.setEngine(engine);      
      
      engine.init    
      puts("engine initilized and ready") if engine.ready?        
      engine.start
        
      layout.init        
      puts("layout initialized and ready") if layout.ready?
      layout.start

      engine
    end

  end

end