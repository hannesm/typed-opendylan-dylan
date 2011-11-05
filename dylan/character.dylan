Module:    internal
Author:    Jonathan Bachrach
Copyright:    Original Code is Copyright (c) 1995-2004 Functional Objects, Inc.
              All rights reserved.
License:      Functional Objects Library Public License Version 1.0
Dual-license: GNU Lesser General Public License
Warranty:     Distributed WITHOUT WARRANTY OF ANY KIND

// BOOTED: define ... class <character> ... end;

define sealed inline method make (class == <character>, #key code)
 => (character :: <byte-character>);
  make(<byte-character>, code: code)
end method make;

define open generic as-uppercase (object :: <object>) => (result :: <object>);
define open generic as-lowercase (object :: <object>) => (result :: <object>);

define sealed inline method as (class == <character>, integer :: <abstract-integer>)
 => (result)
  as(<byte-character>, integer)
end method as;

define sealed inline method \=
    (character-1 :: <character>, character-2 :: <character>) => (well? :: <boolean>)
  as(<integer>, character-1) = as(<integer>, character-2)
end method \=;

define sealed inline method \< 
    (character-1 :: <character>, character-2 :: <character>) => (well? :: <boolean>)
  as(<integer>, character-1) < as(<integer>, character-2)
end method \<;

define sealed method as-uppercase (character :: <byte-character>) 
 => (uppercase-character :: <byte-character>)
  if (character.lowercase?)
    as(<byte-character>,
       as(<integer>, character) + (as(<integer>, 'A') - as(<integer>, 'a')))
  else
    character
  end if
end method as-uppercase;

define sealed method as-lowercase (character :: <byte-character>)
 => (lowercase-character :: <byte-character>)
  if (character.uppercase?)
    as(<byte-character>,
       as(<integer>, character) + (as(<integer>, 'a') - as(<integer>, 'A')))
  else
    character
  end if
end method as-lowercase;

///// EXTRAS FROM COMMON LISP

// TODO: OBSOLETE?

/*
define function alpha? (character :: <character>) => (result :: <boolean>)
  let code :: <integer> = as(<integer>, character);
  (code >= as(<integer>, 'a') & code <= as(<integer>, 'z'))
  | (code >= as(<integer>, 'A') & code <= as(<integer>, 'Z'))
end function alpha?;
*/

define inline function lowercase? (character :: <byte-character>)
 => (result :: <boolean>)
  let code :: <integer> = as(<integer>, character);
  code >= as(<integer>, 'a') & code <= as(<integer>, 'z')
end function lowercase?;

define inline function uppercase? (character :: <byte-character>)
 => (result :: <boolean>)
  let code :: <integer> = as(<integer>, character);
  code >= as(<integer>, 'A') & code <= as(<integer>, 'Z')
end function uppercase?;

////
//// <BYTE-CHARACTER>
////

// BOOTED: define ... class <byte-character> ... end;

//  (code init-keyword: code: type: <integer>)

define macro character-definer
  { define character "<" ## ?:name ## "-character>" }
    => { define sealed inline method make
	     (class == "<" ## ?name ## "-character>", 
              #key code :: "<" ## ?name ## "-integer>")
	  => (character :: "<" ## ?name ## "-character>")
	   as("<" ## ?name ## "-character>", code)
	 end method make;

	 define sealed inline method as 
	     (class == <abstract-integer>, character :: "<" ## ?name ## "-character>")
	  => (code :: "<" ## ?name ## "-integer>");
	   as(<integer>, character)
	 end method as;

	 define sealed inline method as 
	     (type :: <limited-integer>, character :: "<" ## ?name ## "-character>")
	  => (code :: "<" ## ?name ## "-integer>");
	   as(<integer>, character)
	 end method as;

	 define sealed inline method as
	     (class == <integer>, character :: "<" ## ?name ## "-character>")
	  // => (code :: "<" ## ?name ## "-integer>");
	  //  let code :: "<" ## ?name ## "-integer>"
          //    = raw-as-integer("primitive-" ## ?name ## "-character-as-raw"(character));
          //  code
	  => (code :: <integer>)
	   raw-as-integer("primitive-" ## ?name ## "-character-as-raw"(character))
	 end method as;

	 define sealed inline method as
	     (class == "<" ## ?name ## "-character>", 
              // integer :: "<" ## ?name ## "-integer>")
              integer :: <integer>)
	  => (result :: "<" ## ?name ## "-character>")
	   // (element *byte-characters* integer)
	   "primitive-raw-as-" ## ?name ## "-character"(integer-as-raw(integer))
	 end method as;
         }
end macro;

define constant <byte-integer> = <byte>;
define character <byte-character>;

// ALREADY BOOTED
// (define *byte-characters* (make <vector> size: 256))

/// INITIALIZE *BYTE-CHARACTERS*

// (for ((index from 0 below 256))
//  (set! (element *byte-characters* index) (as <byte-character> index)))

// eof
 
