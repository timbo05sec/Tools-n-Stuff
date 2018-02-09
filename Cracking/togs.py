#!/usr/bin/python3

## This script will create case toggling rules for hashcat
## As written here, the script will create rules to toggle
## up to eight characters within a word.  This may take a
## while to run on slower systems.  Comment out sections at
## the end to make a smaller set of rules that will toggle
## fewer characters in the word.

minval = 0
maxval = 15
for a in range(minval,maxval):
    print("T"+hex(a)[2:].upper())

# Comment out this section of code to take out toggling case on 2 characters in the password
# Commenting out the code from here down will make the hashcat toggles.rule file.
for a in range(minval,maxval-1):
    for b in range(minval+1,maxval):
        print("T"+hex(a)[2:].upper()+"T"+hex(b)[2:].upper())

# Comment out this section of code to take out toggling case on 3 characters in the password
# Commenting out the code from here down will make the hashcat toggles2.rule file.
for a in range(minval,maxval-2):
    for b in range(minval+1,maxval-1):
        for c in range(minval+2,maxval):
            print("T"+hex(a)[2:].upper()+"T"+hex(b)[2:].upper()+"T"+hex(c)[2:].upper())

# Comment out this section of code to take out toggling case on 4 characters in the password
# Commenting out the code from here down will make the hashcat toggles3.rule file.
for a in range(minval,maxval-3):
    for b in range(minval+1,maxval-2):
        for c in range(minval+2,maxval-1):
            for d in range(minval+3,maxval):
                print("T"+hex(a)[2:].upper()+"T"+hex(b)[2:].upper()+"T"+hex(c)[2:].upper()+"T"+hex(d)[2:].upper())

# Comment out this section of code to take out toggling case on 5 characters in the password
# Commenting out the code from here down will make the hashcat toggles4.rule file.
for a in range(minval,maxval-4):
    for b in range(minval+1,maxval-3):
        for c in range(minval+2,maxval-2):
            for d in range(minval+3,maxval-1):
                for e in range(minval+4,maxval):
                    print("T"+hex(a)[2:].upper()+"T"+hex(b)[2:].upper()+"T"+hex(c)[2:].upper()+"T"+hex(d)[2:].upper()+"T"+hex(e)[2:].upper())

# Comment out this section of code to take out toggling case on 6 characters in the password
# Commenting out the code from here down will make the hashcat toggles5.rule file.
for a in range(minval,maxval-5):
    for b in range(minval+1,maxval-4):
        for c in range(minval+2,maxval-3):
            for d in range(minval+3,maxval-2):
                for e in range(minval+4,maxval-1):
                    for f in range(minval+5,maxval):
                        print("T"+hex(a)[2:].upper()+"T"+hex(b)[2:].upper()+"T"+hex(c)[2:].upper()+"T"+hex(d)[2:].upper()+"T"+hex(e)[2:].upper()+"T"+hex(f)[2:].upper())

# Comment out this section of code to take out toggling case on 7 characters in the password
for a in range(minval,maxval-6):
    for b in range(minval+1,maxval-5):
        for c in range(minval+2,maxval-4):
            for d in range(minval+3,maxval-3):
                for e in range(minval+4,maxval-2):
                    for f in range(minval+5,maxval-1):
                        for g in range(minval+6,maxval):
                            print("T"+hex(a)[2:].upper()+"T"+hex(b)[2:].upper()+"T"+hex(c)[2:].upper()+"T"+hex(d)[2:].upper()+"T"+hex(e)[2:].upper()+"T"+hex(f)[2:].upper()+"T"+hex(g)[2:].upper())

# Comment out this section of code to take out toggling case on 8 characters in the password
for a in range(minval,maxval-7):
    for b in range(minval+1,maxval-6):
        for c in range(minval+2,maxval-5):
            for d in range(minval+3,maxval-4):
                for e in range(minval+4,maxval-3):
                    for f in range(minval+5,maxval-2):
                        for g in range(minval+6,maxval-1):
                            for h in range(minval+7,maxval):
                                print("T"+hex(a)[2:].upper()+"T"+hex(b)[2:].upper()+"T"+hex(c)[2:].upper()+"T"+hex(d)[2:].upper()+"T"+hex(e)[2:].upper()+"T"+hex(f)[2:].upper()+"T"+hex(g)[2:].upper()+"T"+hex(h)[2:].upper())
