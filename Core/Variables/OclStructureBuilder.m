classdef OclStructureBuilder < OclStructure
  
  properties
  end
  
  methods
  
    function self = OclStructureBuilder()
    end
    
    function add(self,id,in2)
      % add(id)
      % add(id,length)
      % add(id,size)
      % add(id,obj)
      if nargin==2
        % add(id)
        N = 1;
        M = 1;
        K = 1;
        obj = OclMatrix([N,M]);
      elseif isnumeric(in2) && length(in2) == 1
        % args:(id,length)
        N = in2;
        M = 1;
        K = 1;
        obj = OclMatrix([N,M]);
      elseif isnumeric(in2)
        % args:(id,size)
        N = in2(1);
        M = in2(2);
        K = 1;
        obj = OclMatrix([N,M]);
      else
        % args:(id,obj)
        [N,M,K] = in2.size;
        obj = in2;
      end
      pos = self.len+1:self.len+N*M*K;
      pos = reshape(pos,N,M,K);
      self.addObject(id,obj,pos);
    end
    
    function addRepeated(self,names,arr,N)
      % addRepeated(self,arr,N)
      %   Adds repeatedly a list of structure objects
      %     e.g. ocpVar.addRepeated([stateStructure,controlStructure],20);
      for i=1:N
        for j=1:length(arr)
          self.add(names{j},arr{j})
        end
      end
    end
    
    function addObject(self,id,obj,pos)
      % addVar(id, obj)
      %   Adds a structure object
      
      [N,M,K] = size(pos);
      self.len = self.len+N*M*K;
      
      if ~isfield(self.children, id)
        self.children.(id).type = obj;
        self.children.(id).positions = pos;
      else
        self.children.(id).positions(:,:,end+1:end+K) = pos;
      end
    end
    
  end % methods
end % classdef