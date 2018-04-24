# twweb

The Tetherless World Constellation web site files including style sheets, javaScript, sparql query files and xsl transformation files.

### Query file requirements
For the Tetherless World Constellation web site we store sparql query files in our queries directory. Our query files have a .rq extension but we treat them as php files. To make this work we added the .htaccess file in the directory telling apache to treat rq files as php scripts.

Also, we updated the php.ini file to allow short open tags (<? >) we set set short_open_tag to On.
