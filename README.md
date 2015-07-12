# audioTaggerRenamer

The project purpose is to create 2 bash scripts:
<ul>
<li><b>renameTaggedSongs.sh</b>: Renames songs in a given folder using a conventional pattern using song tags</li>
<li><b>tagSongsByName.sh</b> : Applies tags to songs extracting informations by the filename.</li>
</ul>

Format: <br>
&lt;song_name&gt;-&lt;composer&gt;.&lt;extension&gt; ( in future versions it will be customizable )<br>

Expected usage: <br>
<ul>
<li><b>NOW</b><br>
    ./renameTaggedSongs.sh myFolder/with/songs/<br>
    ./tagSongsByName.sh myFolder/with/songs/<br>
    <br><br>
</li>
<li><b>LATER</b><br>
    ./renameTaggedSongs.sh myFolder/with/songs/ target/folder/ -f "NAME|||COMPOSER|||YEAR"<br>
    ./tagSongsByName.sh myFolder/with/songs/ target/folder/ -f "YEAR|||NAME|||COMPOSER"<br>
<br><br>
</li></ul>
