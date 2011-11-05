Module:    internal
Author:    Jonathan Bachrach
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      Functional Objects Library Public License Version 1.0
Dual-license: GNU Lesser General Public License
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

define limited-stretchy-vector <byte-character> (fill: ' ');

define limited-stretchy-vector-minus-selector <byte> (<limited-stretchy-vector>) (fill: 0);

define limited-stretchy-vector-minus-constructor <element-type>
  (<limited-stretchy-vector>, <limited-collection>) (fill: #f);

define method initialize 
    (vector :: <stretchy-element-type-vector>,
     #key size :: <integer> = 0, capacity :: <integer> = size, 
          element-type :: <type>, fill =  #f) 
 => ()
  next-method();
  unless (size = 0)
    check-type(fill, element-type);
  end unless;
  stretchy-initialize(vector, capacity, size, fill);
  vector
end method initialize;

define sealed domain element-type (<stretchy-element-type-vector>);

define method concrete-limited-stretchy-vector-class
    (of :: <type>) => (res :: <class>)
  <stretchy-element-type-vector>
end method;

/// REALLY NEED SUBTYPE SPECIALIZERS TO GET THIS TO HAPPEN IN MACRO
define method concrete-limited-stretchy-vector-class
    (of :: <limited-integer>) => (res :: <class>)
  select (of by subtype?)
    <byte>        => <stretchy-byte-vector>;
    // <double-byte> => <stretchy-double-byte-vector>;
    otherwise     => <stretchy-element-type-vector>;
  end select;
end method;

define sealed inline method element-setter
    (new-value, collection :: <stretchy-element-type-vector>, index :: <integer>)
 => (object)
  check-type(new-value, element-type(collection));
  if (index < 0) element-range-error(collection, index) end if;
  let collection-size = collection.size;
  if (index >= collection-size) 
    if (index = collection-size)
      collection.trusted-size := index + 1 
    else
      collection.size := index + 1 
    end if
  end if;
  // We assume here that the underlying vector only grows.  
  // If this ceases to be true the following code will need to be changed.
  stretchy-element-type-vector-element
    (collection.stretchy-representation, index) := new-value
end method element-setter;

/// TODO: COULD BE EXPENSIVE UNLESS TYPES ARE CACHED

define sealed inline method type-for-copy
    (vector :: <stretchy-element-type-vector>) => (type :: <type>)
  limited-stretchy-vector(element-type(vector))
end method type-for-copy;

// eof
