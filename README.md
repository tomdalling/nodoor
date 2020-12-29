Nodoor
======

"Vendors can't lock you in if there are no doors"

Nodoor is a "database" that consists of mostly text files in
directories, with associated metadata. The idea is that text files are
open and future-proof, so you won't get locked in to any particular
software. Files and directories will exist for decades into the
future, and so will text editors.

It's pronounced like "Hodor". 

The intended use for this is to standardise my personal journal, wiki,
zettelkasten, and document archive into a unified format. File
metadata can be verified against schemas to ensure data integrity, and
can be queried in a standard way, kind of like SQL but not really.


Usage
-----

Querying a repository of files:

```ruby
repo = Nodoor::Repo.new('/path/to/directory')
zettels = repo.query(path: 'zettelkasten/*.md')
zettels.first.path #=> "zettelkasten/abc.md"
zettels.first.content #=> (the markdown contents of the file, minus the metadata)
zettels.first.metadata #=>
# {
#   title: "Liskov Substitution Principle",
#   tags: [:programming, :design],
# }
```
