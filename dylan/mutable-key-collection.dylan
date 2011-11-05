Module:    internal
Author:    Jonathan Bachrach
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      Functional Objects Library Public License Version 1.0
Dual-license: GNU Lesser General Public License
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND


/// define open abstract class <mutable-explicit-key-collection> ... end;


////////////
// INTERFACE
////////////


// Open generics on <mutable-explicit-key-collection>

define open generic remove-key!
  (collection :: <mutable-explicit-key-collection>, key :: <object>) 
    => (present? :: <boolean>);






