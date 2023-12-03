% Conditionally set Id using reif's if_
{ if_((R #< 13',' G #< 14',' B #< 15),
          number_chars(Id,Id0),
          Id #= 0
          )
       }