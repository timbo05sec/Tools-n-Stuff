#!/bin/bash

# The format of this script is:
# customsha.sh <file with hashes> <dictionary>
# hashfile should be in the format username:hash:salt

while read passworddict
   do
      while read hashnsalt
         do 
            { HASH=`echo -n $(echo -n $hashnsalt | cut -d ':' -f 3)';'$passworddict | shasum | cut -d ' ' -f 1 | tr -d '\n'`
            if [ "$HASH" == "`echo -n $(echo -n $hashnsalt | cut -d ':' -f 2)`" ]
               then
                  echo $(echo -n $hashnsalt | cut -d ':' -f 1)':'$passworddict
            fi } &
      done < $1
done <$2
