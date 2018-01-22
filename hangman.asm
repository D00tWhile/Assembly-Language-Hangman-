TITLE test2.asm
; Program Description : Game of Hangman
; Author: Christina Tsui
; Creation Date : 04 / 13 / 17

INCLUDE Irvine32.inc

;Set up macros to clear registers
clearEAX TEXTEQU <mov eax, 0>
clearEBX TEXTEQU <mov ebx, 0>
clearECX TEXTEQU <mov ecx, 0>
clearEDX TEXTEQU <mov edx, 0>
clearESI TEXTEQU <mov esi, 0>
clearEDI TEXTEQU <mov edi, 0>

.data

welcomePrompt byte 'Welcome to Hangman.', 0Ah, 0Dh,
			 'The game of Hangman involes you guessing your way to find a secret word.', 0Ah, 0Dh,
			 'A guess can be made one letter at a times, or by guessing the entire word.', 0Ah, 0Dh,
			 'Beware: ',0Ah, 0Dh, 
			 'You only have 10 failed attempt at entering a letter, per word', 0Ah, 0Dh,
			 'You only have 3 failed attempts at guessing the secret word, per word', 0Ah, 0Dh,
			 '*****Make your guesses wisely! Let the games begin!*****', 0Ah, 0Dh, 0h

clue byte 50 dup(0h), 0h
hangman byte 30 dup(0h), 0h			 
stringLength byte 0h
totalWins byte 0h
totalLoss byte 0h
wordFailAttempt byte 0h

.code
main PROC

mov edx, offset welcomePrompt;Output welcome message to user
call WriteString
call waitmsg;wait
call clrscr;clear screen
call randomWord;Start game loop

exit
main ENDP

;----------------------------------------------------
randomWord PROC ;uses eax,ebx,ecx,edx,esi,edi
;Desc:  Using a switch case, a word is chosen at 
;       random from a list of preselected words. 
;       the array passed to hangman. A clue is also created.
;Receives: Nothing
;Returns:clue - string with "_" and " "
;	   	 hangman - string choosen at random
;		 stringLength - number of letters in hangman
;----------------------------------------------------

.data

;Hangman words
string0 BYTE "APPLE", 0h
string1 BYTE "CANOE", 0h
string2 BYTE "DOBERMAN", 0h
string3 BYTE "FRAME", 0h
string4 BYTE "BANANA", 0h
string5 BYTE "ORANGE", 0h
string6 BYTE "FRIGATE", 0h
string7 BYTE "KETCHUP", 0h
string8 BYTE "POSTAL", 0h
string9 BYTE "BASKET", 0h
string10 BYTE "CABINET", 0h
string11 BYTE "BIRCH",0h
string12 BYTE "MACHINE", 0h
string13 BYTE "MISSISSIPPIAN", 0h
string14 BYTE "PIZZA", 0h
string15 BYTE "MEOW", 0h

.code

;clear registers
clearEBX
clearEAX
clearECX
clearEDX

call Randomize;Seed the randome number generator
mov eax, 256d ;16^2 can mod 1-16
call RandomRange;get random number range 0-5000, will be eax
mov bl, 16;Divide random number by 16
div bl;Mod is in ah, use ah to select string
mov cl, ah
clearEAX

;switch case which matches cl(moded random number)  to the corrisponding string#
opt1:;Word CANONE
cmp cl, 1h;if match use string1
jne opt2
MOV eSI, OFFSET string1
mov al, lengthof string1
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string1
call copyString ;move string1 to hangman
jmp wordFound

opt2:;Word DOBERMAN
cmp cl, 2h;if match use string2
jnz opt3
MOV eSI, OFFSET string2
mov al, lengthof string2
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string2
call copyString ;move string2 to hangman
jmp wordFound

opt3:;word FRAME
cmp cl, 3h;if match use string3
jnz opt4
MOV eSI, OFFSET string3
mov al, lengthof string3
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string3
call copyString ;move string3 to hangman
jmp wordFound

opt4:;Word BANANA
cmp cl, 4h;if match use string4
jnz opt5
MOV eSI, OFFSET string4
mov al, lengthof string4
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string4
call copyString ;move string4 to hangman
jmp wordFound

opt5:;Word ORANGE
cmp cl, 5h;if match use string5
jnz opt6
MOV eSI, OFFSET string5
mov al, lengthof string5
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string5
call copyString ;move string5 to hangman
jmp wordFound

opt6:;Word FRIGATE
cmp cl, 6h;if match use string6
jnz opt7
MOV eSI, OFFSET string6
mov al, lengthof string6
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string6
call copyString ;move string6 to hangman
jmp wordFound

opt7:;Word KETCHUP
cmp cl, 7h;if match use string7
jnz opt8
MOV eSI, OFFSET string7
mov al, lengthof string7
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string7
call copyString ;move string7 to hangman
jmp wordFound

opt8:;Word POSTAL
cmp cl, 8h;if match use string8
jnz opt9
MOV eSI, OFFSET string8
mov al, lengthof string8
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string8
call copyString ;move string8 to hangman
jmp wordFound

opt9:;Word BASKET
cmp cl, 9h;if match use string9
jnz opt10
MOV eSI, OFFSET string9
mov al, lengthof string9
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string9
call copyString ;move string9 to hangman
jmp wordFound

opt10:;Word CABINET
cmp cl, 0Ah;if match use string10
jnz opt11
MOV eSI, OFFSET string10
mov al, lengthof string10
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string10
call copyString ;move string10 to hangman
jmp wordFound

opt11:;Word BIRCH
cmp cl, 0Bh;if match use string11
jnz opt12
MOV eSI, OFFSET string11
mov al, lengthof string11
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string11
call copyString ;move string11 to hangman
jmp wordFound

opt12:;Word MANCHINE
cmp cl, 0Ch;if match use string12
jnz opt13
MOV eSI, OFFSET string12
mov al, lengthof string12
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string12
call copyString ;move string12 to hangman
jmp wordFound

opt13:;Word MISSISSIPPIAN
cmp cl, 0Dh;if match use string13
jnz opt14
MOV eSI, OFFSET string13
mov al, lengthof string13
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string13
call copyString ;move string13 to hangman
jmp wordFound

opt14:;Word PIZZA
cmp cl, 0Eh;if match use string14
jnz opt15
MOV eSI, OFFSET string14
mov al, lengthof string14
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string14
call copyString ;move string14 to hangman
jmp wordFound

opt15:;Word MEOW
cmp cl, 0Fh;if match use string15
jnz opt16
MOV eSI, OFFSET string15
mov al, lengthof string15
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string15
call copyString ;move string15 to hangman
jmp wordFound

opt16:;Word APPLE
MOV eSI, OFFSET string0;if match use string0
mov al, lengthof string0
MOV eDI, OFFSET hangman
mov cl, LENGTHOF string0
call copyString ;move string0 to hangman
jmp wordFound

wordFound:
call playerMove;Goto player menu options switchcase

ret
randomWord ENDP

;----------------------------------------------------
playerMove PROC ;uses edx, eax 
;Desc:  Prompts the user to enter a choice, and view clue.
;       Player chooses to enter a word or a letter. 
;       The switchcase also has exit and oops. 
;Receives: edx - offset of the strings 
;          ecx - max length of the string
;Returns:  eax - users choice and clue
;----------------------------------------------------

.data

choice byte 'Do you wish to guess a letter or the whole word: (1 for letter, 2 for word, 3 to quit game)', 0Ah, 0Dh, 0h
wordEquals byte 'WORD = ', 0h
oops byte 'Invalid Entry.  Please try again.', 0Ah, 0Dh, 0h
userinput BYTE 0h, 0h

.code

starthere:
call crlf;Next line
mov edx, offset wordEquals
call writestring;output Word = 
mov edx, offset clue
call writestring;output blank lines from clye
call crlf

clearEDX
mov edx, OFFSET choice;output users options 
call WriteString
call ReadDec
mov userinput, al

enterLetter: ;option 1
cmp userinput, 1
jne enterWord
call getPlayerLetter;function to guess letter,10 attempts
jmp starthere;On return restart menu

enterWord: ;option 2
cmp userinput, 2
jne done
call playerWord ;function to guess word, 3 attempts
jmp starthere;On return restart menu

done:;Option 3
cmp userinput, 3
je  theEnd;Leave program
mov edx, OFFSET oops
call WriteString
call waitmsg
jmp starthere;On return restart menu

theEnd:
call scoreboard;call function to find out win/loose
exit;gtfo

ret
playerMove ENDP


;----------------------------------------------------
getPlayerLetter PROC ;uses eax, ebx, ecx, edx, esi, edi
;Desc:  Prompts the user to enter their letter guess.
;       Their letter guess is compared to the hangman string.
;       Hits and misses are told to player and kept track of. 
;Receives: edx - offset of the strings 
;          ecx - max length of the string
;Returns:  eax - users choice and clue
;----------------------------------------------------

.data

match byte 'Yay, match found!', 0ah, 0dh, 0h
noMatch byte 'Oh no, not a match.', 0ah, 0dh, 0h
whichLetter byte 'Please enter your letter guess', 0ah, 0dh, 0h
letterGuess byte 0h, 0h

.code
;get letter from user.
mov edx, offset whichLetter;Ask user what letter guess
call writestring;output
call readchar;get character and move to letterGuess
mov letterGuess, al;save

INVOKE Str_ucase, ADDR letterGuess;change case to upper to make easier.
mov edx, offset letterGuess;Output letter guess so user can keep track.
call writestring
call crlf

clearEDX;total fail counter
clearEAX;counter to know where in array to change value
clearECX;clear the loop
clearEBX

mov esi, offset hangman;access word
mov edi, offset clue;access clue
movzx ecx, stringLength ;access count for loop,

L1:
mov bl, [esi]; move the data so that it can be cmp
cmp bl, letterguess
je letterFound;If there is a match 
jmp letterNOTFound;If there is not a match

letterFound:
push ecx;save the loop counter
push edx;save fail counter
mov cl, letterGuess
mov [edi + (eax)], cl;location to replace
inc esi;keep checking loop
inc eax;move up twice for both '_' & ' '
inc eax
mov edx, offset match;tell player they found a letter
call writestring
add totalWins, 1
call checkLetterProgress
pop edx;fail counter
pop ecx;loop counter
LOOP L1
ret

letterNOTFound:;keeps track if the letter was not found in string
push ecx;save loop counter
inc esi;keep checking loop
inc eax
inc eax;where I am at in array
inc edx;if at end and this is the same at size, no match found
movzx ecx, stringLength ;access count for loop,
cmp edx, ecx;compare string length with the counter
je totalFail
pop ecx;retrieve loop counter
LOOP L1
ret

totalFail:;if each letter failed, tell user
pop ecx;reset stack
mov edx, offset noMatch;the letter was not found at all 
call writestring
add totalLoss, 1
call checkLetterProgress

ret
getPlayerLetter ENDP

;----------------------------------------------------
checkLetterProgress PROC ;uses ecx, edx
;Desc:		Keeps track of failed and successful attempts 
;		    of leter entry. Clears and calls function to 
;		    reset the word, then back to game menu.
;Receives: edx - offset of the strings 
;          ecx - max length of the string
;Returns:  eax - users choice and clue
;----------------------------------------------------

.data

youLost byte 'You ran out of letter guess attempts. You lost this round.', 0ah, 0dh, 0h
youWin byte ' <-----You found the word! You won this round! Try again?', 0ah, 0dh, 0h

.code
push eax;save array location from previous proc

clearEAX
clearEDX

movzx ecx, stringLength ;access count for loop to know if all letters are found
sub cl, 1;account for endline character
cmp totalWins, cl;check if the whole string is known
je changeWordWin
cmp totalLoss, 10;check if 10 attempts have been reached
je changeWordLoss
jmp theEnd

changeWordLoss:;tell user they lost b/c no more attempts left
mov  eax, lightred + (black);make fails a bit more obvious
call SetTextColor
mov edx, offset youLost;
call writestring
call resetStrings;clean string to prevent overlap
mov totalLoss, 0;reset lost count
mov totalWins, 0;reset win counter
mov edx, offset wordFailAttempt
mov wordFailAttempt, 0;reset word enter counter
mov  eax, lightgray + (black);reset color
call SetTextColor
call keepTrackLoss
call randomWord;Will change the word to a new random word
jmp theEnd

changeWordWin:;tell the user they won and what the full word was
mov  eax, yellow + (black);make wins a bit more obvious
call SetTextColor
mov edx, offset hangman
call writestring
mov edx, offset youWin
call writestring
mov  eax, lightgray + (black);reset color
call SetTextColor
call resetStrings;clean string to prevent overlap
mov totalWins, 0;reset win counter
mov totalLoss, 0;reset lost counter
mov edx, offset wordFailAttempt
mov wordFailAttempt, 0;reset word enter counter
call keepTrackWin
call randomWord;Will change the word to a new random word, next round 
jmp theEnd

theEnd:;go back to game menu
pop eax

ret
checkLetterProgress ENDP

;----------------------------------------------------
playerWord PROC ; uses edx, ecx
;Desc:		Gets word guess from user, based off compare function 
;		    the number of fails and wins are tracked.
;		    User knows if they won or lost.
;Receives: edx - offset of the strings 
;          ecx - max length of the string
;Returns:  randomword reset
;----------------------------------------------------

.data

match1 byte ' <----You found the word! Yay, you won this round! Try again?', 0ah, 0dh, 0h
noMatch1 byte 'Oh no, not a match.', 0ah, 0dh, 0h
youLost1 byte 'You ran out of word guess attempts. You lost this round.', 0ah, 0dh, 0h
whichWord byte 'Please enter your word guess. ', 0ah, 0dh, 0h
wordGuess byte 25 dup(0h), 0h
wordGuessCount byte 0h

.code

clearECX
mov edx, offset whichWord;Ask user what letter guess
call writestring;output
mov ecx, 25 
mov edx, offset wordGuess
call readstring;get character and move to letterGuess
mov wordGuessCount, al;save size of the guess, just incase.
INVOKE Str_ucase, ADDR wordGuess;change case to upper to make easier comparison.
call compareString
cmp ecx, 0;if fully went through compare, the loop counter @ 0
je equal
jmp failAttempt

equal:
mov  eax, yellow + (black);make wins a bit more obvious
call SetTextColor
mov edx, offset hangman;output winning word
call writestring
mov edx, offset match1;tell player they won
call writestring
mov  eax, lightgray + (black);reset colors
call SetTextColor
mov eax, offset totalWins
mov totalWins, 0;reset letter count
mov eax, offset totalLoss
mov totalLoss, 0;reset letter count
mov wordFailAttempt, 0;reset word counter
call keepTrackWin
call resetStrings;clean string to prevent overlap
call randomWord;WGoto next round

failAttempt:
mov edx, offset noMatch1;user is told no match
call writestring
add wordFailAttempt, 1;add to fail counter
cmp wordFailAttempt, 3;if word guess fail counter @ 3 game lost
je lostRound
jmp theEnd

lostRound:
mov  eax, lightred + (black);make fails a bit more obvious
call SetTextColor
mov edx, offset youLost1;tell user they lost round
call writestring 
mov eax, lightgray + (black)
call settextcolor
mov eax, offset totalWins
mov totalWins, 0;reset letter count
mov eax, offset totalLoss
mov totalLoss, 0;reset letter count
mov wordFailAttempt, 0;reset word counter
call keepTrackLoss
call resetStrings;clean string to prevent overlap
call randomWord;go to next round

theEnd:

ret
playerWord ENDP

;--------------------------------------------------
resetStrings PROC;edi, ecx, edx
;Desc:		Resets clue and hangman so that on their 
;		    next loop/round there is no remaining 
;		    elements from previous round. 
;Receives: edi - offset of the clue 
;          edi - offset of the hangman
;Returns:  edi - reset clue and hangman
;----------------------------------------------------

;make sure clue is empty from previous round
mov edi, offset clue
mov ecx, 35
clueReset:;loop that will reset the string
mov dl, 0h
mov [edi], dl;make the element '0h'
inc edi
LOOP clueReset

;make sure hangman is empty from previous round
mov edi, offset hangman
mov ecx, 20
hangmanReset:;loop that will reset the string
mov dl, 0h
mov [edi], dl;make the element '0h'
inc edi
LOOP hangmanReset

ret 
resetStrings ENDP

;---------------------------------------------------------
copyString PROC;uses eax, esi, edi, ecx, edx
;Desc:		Copys the random word to hangman.  
;		    Uses hangman to create clue with the 
;		    spaces and underscores.
;Receives: esi - offset of random string 
;          al - length of random string
;		   edi - offset of hangman
;			cl - length of random string
;Returns:  edu - clue
;		   esi - hangman
;--------------------------------------------------------

mov stringLength, cl;loop length, length of string

copying:
mov al, [esi];take from random string
mov [edi], al;move to hangman
inc edi;next element
inc esi;next element
LOOP copying

mov esi, offset hangman;Gather information to create clue
mov edi, offset clue;go to start of clye
mov cl, stringLength;length of string
sub ecx, 1;take away one for the endline

buildClue:;Fill Clue so that it will look "_ _ _ _ _" for the correct string size
mov dl, '_'
mov [edi], dl;First character is '_'
inc edi
mov dl, ' '
mov [edi], dl;second character is ' '
inc edi
LOOP buildClue

ret
copyString ENDP

;-----------------------------------------------------
compareString PROC;uses eax,ecx,edx,esi
;Desc:		Compares each element of the user guess word 
;		    If all elements match, the counter will be 0.
;		    which will return for correct cmp. Elese returning cmp fails.
;Receives: edx - offset of the wordGuess 
;          
;Returns:  ecx - counter of loop
;----------------------------------------------------

mov esi, offset hangman;get hangman
movzx ecx, stringLength ;get string size of the hangman

compare:
mov al, [esi];get element of hangman
mov bl, [edx];get element of guess
cmp al, bl ;compare letters of guess and hangman
jne compareFail;if match keep going through the loop
inc edx;next element
inc esi;next element
loop compare

compareFail:;else stop loop with fail, ecx will be off, which will fail cmp on return

ret
compareString ENDP

;----------------------------------------------------
scoreboard PROC;uses eax, ecx, edx
;Desc:		Outputs users scoreboard. Will change 
;		    color so tht it is easier to view.
;		    Sets trigger for function calls track win/loose
;Receives: edx - exit game, option 3 
;          
;Returns:  ecx - Set to 100, but exits game
;----------------------------------------------------

.data

winning byte 'Total games won: ', 0ah, 0dh, 0h
losing byte 'Total games lost: ', 0ah, 0dh, 0h

.code

mov ecx, 100h;triggers the scoreboard #'s

mov eax, lightgreen + (black);make the score stand out
call settextcolor
mov edx, offset winning;winning
call writestring
call keepTrackWin;Will be triggered to move value to edx
call writedec;output winning number
call crlf

mov edx, offset losing;losing 
call writestring
call keepTrackLoss;Will be triggered to move value to edx
call writedec;output losing number
call crlf
mov eax, lightgray + (black);reset color
call settextcolor

call waitmsg;wait 

ret
scoreboard ENDP

;----------------------------------------------------
keepTrackWin PROC;uses eax, ecx
;Desc:		Depending on trigger being set, will set the register
;			with the win total. Else it will add to the total wins.
;Receives: ecx - trigger value 
;          
;Returns:  eax - needed for writedec
;----------------------------------------------------

.data 

gameWon byte 0

.code

push ecx;save ecx
cmp ecx, 100h;check for scoreboard trigger
jne addOne
movzx eax, gameWon;store data for scoreboard
jmp theEnd

addOne:
add gameWon, 1;add to winning total
jmp theEnd

theEnd:
pop ecx;get ecx back

ret
keepTrackWin ENDP

;----------------------------------------------------
keepTrackLoss PROC;uses ecx, eax
;Desc:		Depending on trigger being set, will set the register
;			with the lost total. Else it will add to the total lost.
;Receives: ecx - trigger value 
;          
;Returns:  eax - needed for writedec
;----------------------------------------------------

.data 

gameLost byte 0

.code

push ecx;save ecx

cmp ecx, 100h;check for scoreboard trigger
jne addOne
movzx eax, gameLost;store data for scoreboard
jmp theEnd

addOne:
add gameLost, 1;add to the winning total
jmp theEnd

theEnd:
pop ecx;get ecx back

ret
keepTrackLoss ENDP

end Main