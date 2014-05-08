Parser File Format:
An ascii art image where each character represents a single tile, 
followed by the enemies which should appear.  

See EXAMPLE_LEVEL.txt for an example... level.  

"^>v<" are North, East, South and West, respetively.  

"LRlr" are North/West, North/East, South/West, and South/East respectively.  
	(That is, they are branches in the path.)  

"-|" are branch East/West and North/South respectively.  

"w" is water (non-buildable terrain).  

"NESW" represent the enemy base, N is north facing (generating enemies to the north)
	E is east facing, etc, etc.  

"P" is the player's base.  

"*" is a starting light tower's location.  

"+" is a starting attack tower's location.  

Blanks (either spaces, or a line which ends prematurely) will be treated 
as blank (buildable) tiles.  

Lines beginning with "#" denote a comment and are ignored by the parser.  
Lines beginning with "@" denote an enemy wave.  

Their format is as follows:
"@" followed by some digits, followed by a comma, followed by more digits,
followed by a space, followed by some letters.

The digits represent the time since the last wave this wave should appear.  
The letters represent the enemies to appear in this wave.  

For example:

@5,10 aaaba

Would spawn enemies 5 seconds after the last wave, they would each 
have a base health of 10, it would spawn an enemy of type "a" followed by another,
followed by a third enemy of type "a" followed by an enemy of type "b" 
followed by another of type "a".  

This is exactly equivalent to:

@5,10 aaab
@0,10 a

While this isn't terribly useful here, it makes sense from a parsing 
point of view, and could be useful to break long enemy waves across lines.  