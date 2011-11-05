Module:    internal
Synopsis:  Invocation of any registered exit-functions at shut-down time
Author:    Tony Mann
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      Functional Objects Library Public License Version 1.0
Dual-license: GNU Lesser General Public License
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND


define variable *registered-exit-functions* = #();


define function register-application-exit-function
    (thunk :: <function>) => ()
  *registered-exit-functions* := pair(thunk, *registered-exit-functions*);
end function;



// call-application-exit-functions is called by the low-level runtime 
// at shutdown
//
define function call-application-exit-functions
    (thunk :: <function>) => ()
  local method call-exit-function (thunk :: <function>) => ()
          thunk();
	end method;
  do(call-exit-function, *registered-exit-functions*);
end function;

