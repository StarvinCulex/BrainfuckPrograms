MEMORY LAYOUT

:0/1 :  0 : 0/1:!255::::::: 0/1:!255: 255:!255:  0 : 0/1: 0/1: 0/1: 0/1:   :   :!255:  0 : 0/1: 255:    : 0/1:    : 0/1:    :::::
 MARK:HEAD:MARK:CHAR::etc::MARK:CHAR:MARK:SWAP:ZERO:TEMP: WI : WEI: WIB:reserve:NULA:NULL: VS :MARK:SWAP:MARK:BYTE:MARK:BYTE::etc
::  S  C  R  I  P  T    S  E  G  M  E  N  T  :::           R  E  G  I  S  T  E  R  S         ::: D A T A  V E C T O R  (infinite)



init Script Fragment
(EOF eq NEWLINE)
+ set HEAD MARK 1
>>>, move to first Char Struct CHAR and read char
----- ----- [ +++++ +++++ while the char is not NEWLINE(ascii 10)
  >>,                     move to next Char Struct CHAR and read char
----- ----- ] +++++ +++++ end while the char is not NEWLINE(ascii 10)
>- set SWAP MARK 255

init Registers
>>>>> >>>>>+ set VS 1
move to Registers' tail

init Data Vector
>-               move to SWAP MARK and set it 255
>>+              set first Byte Struct MARK 1
<<<<< <<<<< <<   back to Script SWAP

execute
----- ----- [ while SWAP is not NEWLINE(ascii 10)
              and SWAP eq SWAP minus 10

  ----- ----- ----- ----- -----
  ----- ---   SWAP eq SWAP minus 33 (ADD minus NEWLINE)
  if SWAP is ADD
FUNCTION if script SWAP now is 0
  [           if script SWAP now is not 0
    >>+       then set TEMP 1
  <]          then pointer points ZERO to stop loop
  FUNCTION pointer points script swap MARK
    +[-<+]-
  >>>-[       if TEMP is 0
    +         clear TEMP whatever
  now pointer points TEMP
END FUNCTION
  >>>>> >>>   pointer points VS
FUNCTION open data vector if closed
  -[ if not opened
    >  pointer points vector MARK
    FUNCTION pointer points vector CHOSEN MARK
      -[+>>-]+
    >[  while chosen BYTE is not 0
      - BYTE eq BYTE minus 1
      > pointer points a MARK
      FUNCTON pointer points vector SWAP MARK
        +[-<<+]-
      > pointer points SWAP
      + SWAP eq SWAP plus 1
      > pointer points MARK
      -[+>>-]+ pointer points vector CHOSEN MARK
    >]  end while
    <        pointer points vector MARK
    +[-<<+]- pointer points vector SWAP MARK
    <+       pointer backs to VS and set it 0
  ]  end if
  +  set VS 1 whatever
END FUNCTION
    >>+         data vector SWAP eq SWAP plus 1
    <<<<< <<<<<  pointer back to TEMP
  ]           end FUNCTION IF
  <<          pointer points script SWAP
  if SWAP is INPUT
  - SWAP eq SWAP minus 1 (INPUT minus ADD)
  [>>+<]+[-<+]->>>-[+ if script SWAP now is 0
    >>>>> >>>                                         pointer points VS
    -[>-[+>>-]+>[->+[-<<+]->+>-[+>>-]+>]<+[->>+]+<+]+ open data vector if closed
    >>,                                               input to data vector SWAP
    <<<<< <<<<<                                       pointer back to TEMP
  ]                                                   end if
  <<          pointer points script SWAP

  if SWAP is SUB
  - SWAP eq SWAP minus 1 (SUB minus INPUT)
  [>>+<]+[-<+]->>>-[+ if script SWAP now is 0
    >>>>> >>>                                         pointer points VS
    -[>-[+>>-]+>[->+[-<<+]->+>-[+>>-]+>]<+[->>+]+<+]+ open data vector if closed
    >>-                                               data vector SWAP eq SWAP minus 1
    <<<<< <<<<<                                       pointer back to TEMP
  ]                                                   end if
  <<          pointer points script SWAP

  if SWAP is OUTPUT
  - SWAP eq SWAP minus 1 (OUTPUT minus SUB)
  [>>+<]+[-<+]->>>-[+                                 if script SWAP now is 0
    >>>>> >>>                                         pointer points VS
    -[>-[+>>-]+>[->+[-<<+]->+>-[+>>-]+>]<+[->>+]+<+]+ open data vector if closed
    >>.                                               output data vector SWAP
    <<<<< <<<<<                                       pointer back to TEMP
  ]                                                   end if
  <<          pointer points script SWAP

  if SWAP is LEFT
  ----- ----- ---- SWAP eq SWAP minus 14 (LEFT minus OUTPUT)
  [>>+<]+[-<+]->>>-[+ if script SWAP now is 0
    >>>>> >>>         pointer points VS
FUNCTION close data vector if opened
      [-           if VS is 1 then set it 0
        >>         pointer points SWAP
        [          while SWAP is not 0
          -        SWAP eq SWAP minus 1
          >        pointer points a MARK
          -[+>>-]+ pointer points vector CHOSEN MARK
          >+       CHOSEN BYTE eq CHOSEN BYTE plus 1
          <        pointer points a MARK
          +[-<<+]- pointer points vector SWAP MARK
          >        pointer points SWAP
        ]          end whlie
        <<         pointer points VS
      ]            end if
END FUNCTION close data vector if opened
    >          pointer points a MARK
    -[+>>-]+   pointer points vector CHOSEN MARK
    -          unset chosen MARK
    <<+        set previous MARK CHOSEN
    +[-<<+]-   pointer points vector SWAP MARK
    <<<<< <<<< pointer back to TEMP
  ]            end if
  <<           pointer points script SWAP

  if SWAP is RIGHT
  --               SWAP eq SWAP minus 2 (RIGHT minus LEFT)
  [>>+<]+[-<+]->>>-[+               if script SWAP now is 0
    >>>>> >>>                       pointer points VS
    [->>[->-[+>>-]+>+<+[-<<+]->]<<] close data vector if opened
    >                               pointer points a MARK
    -[+>>-]+                        pointer points vector CHOSEN MARK
    -                               unset chosen MARK
    >>+                             set next MARK CHOSEN
    +[-<<+]-                        pointer points vector SWAP MARK
    <<<<< <<<<                      pointer back to TEMP
  ]                                 end if

  >>>+                              set WIB 1
  <<<<<                             pointer points script SWAP
  if SWAP is WHILE
  ----- ----- ----- ----- -----
  ----                                                SWAP eq SWAP minus 29 (WHILE minus RIGHT)
  [>>+<]+[-<+]->>>-[+                                 if script SWAP now is 0
    >+                                                set WI 1
    >>-                                               set WIB 0
    >>>>>                                             pointer points VS
    -[>-[+>>-]+>[->+[-<<+]->+>-[+>>-]+>]<+[->>+]+<+]+ open data vector if closed
    >>>>> >>>>> [                                     if vector SWAP is not 0
      <<<<< <<+                                       set WIB 1
      <<-                                             set WI 0
      >>>>> >                                         pointer points NULL
    ]                                                 end if and now pointer has 2 possible locations
    <+[->>>+]-                                        pointer points vector swap MARK
    <<<<< <<<<                                        pointer back to TEMP
  ]                                                   end if

  <<--                                                SWAP eq SWAP minus 2 (WEND minus WHILE)
  [>>+<]+[-<+]->>>-[+                                 if script SWAP now is 0
    >>>>> >>>                                         pointer points VS
    -[>-[+>>-]+>[->+[-<<+]->+>-[+>>-]+>]<+[->>+]+<+]+ open data vector if closed
    >>>>> >>>>> [                                     if vector SWAP is not 0
      <<<<< <<-                                       set WIB 0
      <                                               set WEI 1
      >>>>>                                           pointer points NULL
    ]                                                 end if and now pointer has 2 possible locations
    <+[->>>+]-                                        pointer points vector swap MARK
    <<<<< <<<<                                        pointer back to TEMP
  ]                                                   end if

  << pointer points Script SWAP
  +++++ +++++ +++++ +++++ +++++
  +++++ +++++ +++++ +++++ +++++
  +++++ +++++ +++++ +++++ +++++
  +++++ +++++ +++++ +++ SWAP eq SWAP plus 93 (WEND)
  move SWAP back to the chosen Char Struct
  [   while SWAP is not 0
    - SWAP eq SWAP minus 1
    < pointer points swap mark
FUNCTION find the chosen mark (for script)
      -[+  while MARK is not the chosen mark(1)
        << let pointer points the previous MARK
      -]+  end while
    end find the chosen mark
    >+ CHAR eq CHAR plus 1
    >  let pointer points to a MARK
FUNCTION back to swap mark (for script)
      +[-  while MARK is not the swap mark(255)
        >> let pointer points the next MARK
      +]-  end while
      end back to swap mark
    >  let pointer points Script SWAP
  ] end while

  script cursor moving
  pointer points Script SWAP
  >>>[-  if WI
    move script cursor after WHILE_END
    (undefined behavior when WHILE_END not found)
    <<<<     pointer points swap mark
    -[+<<-]+ find the chosen mark (whose CHAR should be WHILE_HEAD)
    -        set chosen mark to 0
    >        pointer points CHAR position
    find WHILE_END
      if CHAR is not WHILE_END
        ----- ----- ----- ----- -----
        ----- ----- ----- ----- -----
        ----- ----- ----- ----- -----
        ----- ----- ----- ----- -----
        ----- ----- ----- ---          ascii of WHILE_END(93)
        [
        +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +++          ascii of WHILE_END(93)
      >> pointer points next CHAR position
      end if CHAR is not WHILE_END(93)
        ----- ----- ----- ----- -----
        ----- ----- ----- ----- -----
        ----- ----- ----- ----- -----
        ----- ----- ----- ----- -----
        ----- ----- ----- ---          ascii of WHILE_END(93)
        ]
        +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +++          ascii of WHILE_END(93)
    pointer points CHAR which eq WHILE_END
    >+       make next mark chosen
    +[->>+]- back to swap mark
    >>>>     pointer back to WI
  ] > [- else if WEI
    move script cursor after WHILE_BEGIN
    (undefined behavior when WHILE_BEGIN not found)
    <<<<<    pointer points swap mark
    -[+<<-]+ find the chosen mark (whose CHAR should be WHILE_END)
    -        set chosen mark to 0
    <        pointer points CHAR position
    find WHILE_HEAD
      if CHAR is not WHILE_HEAD
        ----- ----- ----- ----- -----
        ----- ----- ----- ----- -----
        ----- ----- ----- ----- -----
        ----- ----- ----- ----- -----
        ----- ----- ----- -            ascii of WHILE_HEAD(91)
        [
        +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +            ascii of WHILE_HEAD(91)
      << pointer points previous CHAR position
      end if CHAR is not WHILE_END(93)
        ----- ----- ----- ----- -----
        ----- ----- ----- ----- -----
        ----- ----- ----- ----- -----
        ----- ----- ----- ----- -----
        ----- ----- ----- -            ascii of WHILE_HEAD(91)
        ]
        +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +++++ +++++
        +++++ +++++ +++++ +            ascii of WHILE_HEAD(91)
    pointer points CHAR which eq WHILE_HEAD
    >+       make next mark chosen
    +[->>+]- back to swap mark
    >>>>>    pointer points WEI
  ] > [- else if WIB
    right shift script cursor
    <<<<<<   pointer points swap mark
    -[+<<-]+ find the chosen mark
    -        unset chosen mark
    >>+      set next mark chosen
    +[->>+]- back to swap mark
    >>>>>>   pointer points WIB
  ]

  move the chosen Char Struct to Script SWAP
  pointer points WIB
  <<<<<<    pointer move to mark
  -[+<<-]+  find the chosen mark
  >[        while chosen CHAR
  -         CHAR eq CHAR minus 1
  >
  +[->>+]-  back to swap mark
  >+        SWAP eq SWAP plus 1
  <
  -[+<<-]+  find the chosen mark
  >]        end while
  +[->>+]-  back to swap mark
  >         move to script swap
  pointer points SWAP MARK

] end while and stop execute script