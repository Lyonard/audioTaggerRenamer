# audioTaggerRenamer

The project purpose is to create 2 bash scripts:
- renameTaggedSongs.sh: Renames songs in a given folder using a conventional pattern using song tags
- tagSongsByName.sh : Applies tags to songs extracting informations by the filename.

Format: 
<song_name>-<composer>.<extension>  ( in future versions it will be customizable )

Expected usage: 
-- NOW
    ./renameTaggedSongs.sh myFolder/with/songs/
    ./tagSongsByName.sh myFolder/with/songs/
    
-- LATER 
    ./renameTaggedSongs.sh myFolder/with/songs/ "NAME|||COMPOSER|||YEAR"
    ./tagSongsByName.sh myFolder/with/songs/ "YEAR|||NAME|||COMPOSER"
    
