classdef OclTestLinearSystem < OclSystem
  methods
    function setupVariables(self)
      self.addState('p');
      self.addState('v');
      
      self.addControl('F');

    end
    function setupEquation(self,x,z,u,p)
      m = 1;
      
      self.setODE('p', x.v);
      self.setODE('v', u.F/m);
    end
  end
end